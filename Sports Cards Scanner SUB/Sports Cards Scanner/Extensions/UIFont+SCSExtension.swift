import UIKit

enum CustomFont: String {
    case interMedium = "Inter-Medium"
    case interRegular = "Inter-Regular"
    case interSemibold = "Inter-SemiBold"
    case interBold = "Inter-Bold"
    case poppinsMedium = "Poppins-Medium"
    case opensansRegular = "OpenSans-Regular"
    case sfProDisplaySemibold = "SFProDisplay-Semibold"

    var name: String { self.rawValue }
}

extension UIFont {
    class func font(_ font: CustomFont, size: CGFloat) -> UIFont {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return UIFont(name: font.name, size: size) ?? .systemFont(ofSize: size)
    }
}
