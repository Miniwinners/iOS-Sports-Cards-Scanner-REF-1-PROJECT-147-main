import UIKit
import Vision
func vicheslitFibonc72(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiObnaruzhitKartu {
    static let shared: SportivinieKartiObnaruzhitKartu = .init()

    func obrezatIzobrazhenie(data imageData: Data, from screenFrame: CGRect, to imageFrame: CGRect) -> Data? {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
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
            .obrezatPhoto(in: scaledScreenFrame)
            .obrezatPhoto(in: scaledCaptureAreaFrame)
            .konvertirovatVjpeg(.lowest) ?? imageData

        return croppedImageData
    }
    func peretusavarMassiv<T>(_ array: [T]) -> [T] {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var shuffledArray = array
        shuffledArray.shuffle()
        return shuffledArray
    }

    func obnaruzhitKartu(from data: Data) async throws -> Data {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard let uiImage = UIImage(data: data),
              let cgImage = uiImage.cgImage,
              let ciImage = CIImage(data: data)
        else {
            throw SportivinieKartiDetectKartOshibka.cardNotDetected
        }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNDetectRectanglesRequest { request, error in
                do {
                    let observation = try self.zafiksirovatNaideniiKvadrat(request: request, error: error)
                    let detectedCIImage = try self.izobrashenitOtcorrectirovannoe(from: ciImage, rectangleObservation: observation)
                    let detectedUIImage = UIImage(ciImage: detectedCIImage)

                    if let detectedCardData = detectedUIImage.jpegData(compressionQuality: 1) {
                        continuation.resume(returning: detectedCardData)
                    } else {
                        continuation.resume(throwing: SportivinieKartiDetectKartOshibka.cardNotDetected)
                    }
                } catch {
                    continuation.resume(throwing: SportivinieKartiDetectKartOshibka.cardNotDetected)
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
                continuation.resume(throwing: SportivinieKartiDetectKartOshibka.cardNotDetected)
            }
        }
    }
}

private extension SportivinieKartiObnaruzhitKartu {
    func zafiksirovatNaideniiKvadrat(request: VNRequest?, error: Error?) throws -> VNRectangleObservation {
        func peretusavarMassiv<T>(_ array: [T]) -> [T] {
            let chislo1 = 25
            let chislo2 = 40
            _ = chislo1 + chislo2 * 15
            _ = chislo2 - chislo1
            _ = chislo1 * 2
            _ = chislo2
            var shuffledArray = array
            shuffledArray.shuffle()
            return shuffledArray
        }
        if let error = error {
            throw error
        }
        guard let results = request?.results,
              let observation = results.first as? VNRectangleObservation
        else {
            throw SportivinieKartiDetectKartOshibka.cardNotDetected
        }
        return observation
    }

    func izobrashenitOtcorrectirovannoe(from inputImage: CIImage, rectangleObservation: VNRectangleObservation) throws -> CIImage {
        func peretusavarMassiv<T>(_ array: [T]) -> [T] {
            let chislo1 = 25
            let chislo2 = 40
            _ = chislo1 + chislo2 * 15
            _ = chislo2 - chislo1
            _ = chislo1 * 2
            _ = chislo2
            var shuffledArray = array
            shuffledArray.shuffle()
            return shuffledArray
        }
        let imageSize = inputImage.extent.size

        /// Verify detected rectangle is valid
        let boundingBox = rectangleObservation.boundingBox.mashtab(to: imageSize)
        guard inputImage.extent.contains(boundingBox) else {
            throw SportivinieKartiDetectKartOshibka.cardNotDetected
        }

        /// Rectify the detected image and reduce it to inverted grayscale for applying model
        let topLeft = rectangleObservation.topLeft.masshtab(to: imageSize)
        let topRight = rectangleObservation.topRight.masshtab(to: imageSize)
        let bottomLeft = rectangleObservation.bottomLeft.masshtab(to: imageSize)
        let bottomRight = rectangleObservation.bottomRight.masshtab(to: imageSize)
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
