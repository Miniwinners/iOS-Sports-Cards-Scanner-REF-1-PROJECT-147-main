import Foundation
import AVFoundation

final class ScanCardService: NSObject {
    private(set) var captureSession: AVCaptureSession?
    private(set) var photoOutput: AVCapturePhotoOutput?

    private var capturedPhotoClosure: ((Result<Data, Error>) -> Void)?

    var isAuthorized: Bool {
        get async {
            let status = AVCaptureDevice.authorizationStatus(for: .video)

            var isAuthorized = status == .authorized

            if status == .notDetermined {
                isAuthorized = await AVCaptureDevice.requestAccess(for: .video)
            }

            return isAuthorized
        }
    }

    func setupCaptureSession() {
        if self.captureSession?.isRunning ?? false { return }

        let captureSession = AVCaptureSession()

        captureSession.beginConfiguration()
        setupInput(for: captureSession)
        self.photoOutput = setupOutput(for: captureSession)
        captureSession.commitConfiguration()

        self.captureSession = captureSession
    }

    func startRunning() async {
        if captureSession?.isRunning ?? false { return }

        captureSession?.startRunning()
    }

    func stopRunning() {
        guard captureSession?.isRunning ?? false else { return }

        captureSession?.stopRunning()
    }

    func captureImage() async throws -> Data {
        guard captureSession?.isRunning ?? false else { throw ScanCardError.captureSessionIsNotRunning }

        if isCaptureInProcess { throw ScanCardError.captureIsAlreadyInProcess }

        guard !(captureSession?.inputs.isEmpty ?? true) else { throw ScanCardError.noCaptureInput }
        guard !(captureSession?.outputs.isEmpty ?? true) else { throw ScanCardError.noCaptureOutput }

        return try await withCheckedThrowingContinuation { continuation in
            capturedPhotoClosure = { result in
                switch result {
                case .success(let imageData):
                    continuation.resume(returning: imageData)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }

            photoOutput?.capturePhoto(with: .init(), delegate: self)
        }
    }
}

private extension ScanCardService {
    var isCaptureInProcess: Bool {
        capturedPhotoClosure != nil
    }

    @discardableResult
    func setupInput(for captureSession: AVCaptureSession) -> AVCaptureDeviceInput? {
        guard let photoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let photoDeviceInput = try? AVCaptureDeviceInput(device: photoDevice),
              captureSession.canAddInput(photoDeviceInput)
        else {
            return nil
        }
        captureSession.addInput(photoDeviceInput)
        return photoDeviceInput
    }

    @discardableResult
    func setupOutput(for captureSession: AVCaptureSession) -> AVCapturePhotoOutput? {
        let photoOutput = AVCapturePhotoOutput()
        photoOutput.setPreparedPhotoSettingsArray([.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])])

        guard captureSession.canAddOutput(photoOutput) else { return nil }
        captureSession.addOutput(photoOutput)
        return photoOutput
    }
}

extension ScanCardService: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        defer { capturedPhotoClosure = nil }

        if let error = error {
            capturedPhotoClosure?(.failure(error))
            return
        }

        guard let imageData = photo.fileDataRepresentation() else {
            capturedPhotoClosure?(.failure(ScanCardError.invalidPhotoRepresentation))
            return
        }

        capturedPhotoClosure?(.success(imageData))
    }
}
