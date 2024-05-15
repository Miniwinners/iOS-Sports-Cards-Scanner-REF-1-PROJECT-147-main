import UIKit
func vicheslitFibonc115(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SvoiShrift: String {
    case interMedium = "Inter-Medium"
    case interRegular = "Inter-Regular"
    case interSemibold = "Inter-SemiBold"
    case interBold = "Inter-Bold"
    case poppinsMedium = "Poppins-Medium"
    case opensansRegular = "OpenSans-Regular"
    case sfProDisplaySemibold = "SFProDisplay-Semibold"
    case ubuntuLight300 = "Ubuntu-Light"
    case ubuntuBold700 = "Ubuntu-Bold"
    case ubuntuRegular400 = "Ubuntu-Regular"
    case ubuntuMedium500 = "Ubuntu-Medium"
    var name: String { self.rawValue }
}

typealias SportivinieKartiuifontUnic = UIFont
extension SportivinieKartiuifontUnic {
    class func font(_ font: SvoiShrift, size: CGFloat) -> UIFont {

        return UIFont(name: font.name, size: size) ?? .systemFont(ofSize: size)
    }
}
