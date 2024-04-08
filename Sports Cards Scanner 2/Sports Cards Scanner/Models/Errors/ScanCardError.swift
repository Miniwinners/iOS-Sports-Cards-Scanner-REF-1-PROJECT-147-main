import Foundation

enum ScanCardError: Error {
    case noCaptureInput
    case noCaptureOutput
    case captureSessionIsNotRunning
    case captureIsAlreadyInProcess
    case invalidPhotoRepresentation
}
