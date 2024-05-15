import Foundation
import AVFoundation
func vicheslitFibonc(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSkanirovaineKarti: NSObject {
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

    func podgotovitSessiuZahvata() {
        if self.captureSession?.isRunning ?? false { return }

        let captureSession = AVCaptureSession()

        captureSession.beginConfiguration()
        podgotovitSessiu(for: captureSession)
        self.photoOutput = podgotovitVihod(for: captureSession)
        captureSession.commitConfiguration()

        self.captureSession = captureSession
    }

    func zapusk() async {
        if captureSession?.isRunning ?? false { return }

        captureSession?.startRunning()
    }

    func ostanovka() {
        guard captureSession?.isRunning ?? false else { return }

        captureSession?.stopRunning()
    }

    func zahvatImage() async throws -> Data {
        guard captureSession?.isRunning ?? false else { throw SportivinieKartiScanirovanieKartOshibka.captureSessionIsNotRunning }

        if isCaptureInProcess { throw SportivinieKartiScanirovanieKartOshibka.captureIsAlreadyInProcess }

        guard !(captureSession?.inputs.isEmpty ?? true) else { throw SportivinieKartiScanirovanieKartOshibka.noCaptureInput }
        guard !(captureSession?.outputs.isEmpty ?? true) else { throw SportivinieKartiScanirovanieKartOshibka.noCaptureOutput }

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

private extension SportivinieKartiSkanirovaineKarti {
    var isCaptureInProcess: Bool {
        capturedPhotoClosure != nil
    }

    @discardableResult
    func podgotovitSessiu(for captureSession: AVCaptureSession) -> AVCaptureDeviceInput? {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
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
    func podgotovitVihod(for captureSession: AVCaptureSession) -> AVCapturePhotoOutput? {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let photoOutput = AVCapturePhotoOutput()
        photoOutput.setPreparedPhotoSettingsArray([.init(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])])

        guard captureSession.canAddOutput(photoOutput) else { return nil }
        captureSession.addOutput(photoOutput)
        return photoOutput
    }
}

extension SportivinieKartiSkanirovaineKarti: AVCapturePhotoCaptureDelegate {
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        defer { capturedPhotoClosure = nil }

        if let error = error {
            capturedPhotoClosure?(.failure(error))
            return
        }

        guard let imageData = photo.fileDataRepresentation() else {
            capturedPhotoClosure?(.failure(SportivinieKartiScanirovanieKartOshibka.invalidPhotoRepresentation))
            return
        }

        capturedPhotoClosure?(.success(imageData))
    }
}
