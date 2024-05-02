import UIKit

extension UIImage {

    enum SCSJPEGQuality: CGFloat {
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }

    func croppedImage(in rect: CGRect) -> UIImage {
        UIGraphicsImageRenderer(size: rect.size, format: imageRendererFormat).image { _ in
            draw(in: CGRect(origin: CGPoint(x: -rect.origin.x, y: -rect.origin.y), size: size))
        }
    }

    func convertedToJPEG(_ quality: SCSJPEGQuality) -> Data? {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return jpegData(compressionQuality: quality.rawValue)
    }

}
