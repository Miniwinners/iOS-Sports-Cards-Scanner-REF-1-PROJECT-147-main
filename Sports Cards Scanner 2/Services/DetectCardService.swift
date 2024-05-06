import UIKit
import Vision

final class DetectCardService {
    static let shared: DetectCardService = .init()

    func cropImage(data imageData: Data, from screenFrame: CGRect, to imageFrame: CGRect) -> Data? {
        let uiImage = UIImage(data: imageData)
        let uiImageSize = uiImage?.size ?? screenFrame.size

        let imageToScreenScale = min(uiImageSize.width / screenFrame.width, uiImageSize.height / screenFrame.height)

        let screenTranslateX = max(0, (uiImageSize.width - screenFrame.width * imageToScreenScale) / 2)
        let screenTranslateY = max(0, (uiImageSize.height - screenFrame.height * imageToScreenScale) / 2)
        let scaledScreenFrame = screenFrame
            .applying(.init(scaleX: imageToScreenScale, y: imageToScreenScale))
            .applying(.init(translationX: screenTranslateX, y: screenTranslateY))

        let captureAreaFrame = imageFrame
        let captureAreaTranslateX = max(0, (screenFrame.width - captureAreaFrame.width) * imageToScreenScale / 2)
        let captureAreaTranslateY = max(0, (screenFrame.height - captureAreaFrame.height) * imageToScreenScale / 2)
        let scaledCaptureAreaFrame = captureAreaFrame
            .applying(.init(scaleX: imageToScreenScale, y: imageToScreenScale))
            .applying(.init(translationX: captureAreaTranslateX, y: captureAreaTranslateY))

        let croppedImageData = uiImage?
            .croppedImage(in: scaledScreenFrame)
            .croppedImage(in: scaledCaptureAreaFrame)
            .convertedToJPEG(.lowest) ?? imageData

        return croppedImageData
    }

    func detectCard(from data: Data) async throws -> Data {
        guard let uiImage = UIImage(data: data),
              let cgImage = uiImage.cgImage,
              let ciImage = CIImage(data: data)
        else {
            throw DetectCardError.cardNotDetected
        }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNDetectRectanglesRequest { request, error in
                do {
                    let observation = try self.handleDetectedRectangle(request: request, error: error)
                    let detectedCIImage = try self.perspectiveCorrectedImage(from: ciImage, rectangleObservation: observation)
                    let detectedUIImage = UIImage(ciImage: detectedCIImage)

                    if let detectedCardData = detectedUIImage.jpegData(compressionQuality: 1) {
                        continuation.resume(returning: detectedCardData)
                    } else {
                        continuation.resume(throwing: DetectCardError.cardNotDetected)
                    }
                } catch {
                    continuation.resume(throwing: DetectCardError.cardNotDetected)
                }
            }

            request.minimumAspectRatio = 0.0
            request.maximumAspectRatio = 1.0
            request.maximumObservations = 1

            let imageRequestHandler = VNImageRequestHandler(
                cgImage: cgImage,
                orientation: .up
            )

            do {
                try imageRequestHandler.perform([request])
            } catch {
                continuation.resume(throwing: DetectCardError.cardNotDetected)
            }
        }
    }
}

private extension DetectCardService {
    func handleDetectedRectangle(request: VNRequest?, error: Error?) throws -> VNRectangleObservation {
        if let error = error {
            throw error
        }
        guard let results = request?.results,
              let observation = results.first as? VNRectangleObservation
        else {
            throw DetectCardError.cardNotDetected
        }
        return observation
    }

    func perspectiveCorrectedImage(from inputImage: CIImage, rectangleObservation: VNRectangleObservation) throws -> CIImage {
        let imageSize = inputImage.extent.size

        /// Verify detected rectangle is valid
        let boundingBox = rectangleObservation.boundingBox.scaled(to: imageSize)
        guard inputImage.extent.contains(boundingBox) else {
            throw DetectCardError.cardNotDetected
        }

        /// Rectify the detected image and reduce it to inverted grayscale for applying model
        let topLeft = rectangleObservation.topLeft.scaled(to: imageSize)
        let topRight = rectangleObservation.topRight.scaled(to: imageSize)
        let bottomLeft = rectangleObservation.bottomLeft.scaled(to: imageSize)
        let bottomRight = rectangleObservation.bottomRight.scaled(to: imageSize)
        let correctedImage = inputImage
            .cropped(to: boundingBox)
            .applyingFilter(
                "CIPerspectiveCorrection",
                parameters: [
                    "inputTopLeft": CIVector(cgPoint: topLeft),
                    "inputTopRight": CIVector(cgPoint: topRight),
                    "inputBottomLeft": CIVector(cgPoint: bottomLeft),
                    "inputBottomRight": CIVector(cgPoint: bottomRight)
                ]
            )

        return correctedImage
    }
}
