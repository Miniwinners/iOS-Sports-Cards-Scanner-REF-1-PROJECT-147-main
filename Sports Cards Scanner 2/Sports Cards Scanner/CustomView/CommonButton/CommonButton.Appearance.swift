import UIKit

extension CommonButton {
    struct SCSAppearance {
        var configuration: UIButton.Configuration = .plain()
        var font: UIFont = .font(.ubuntuMedium500, size: 18)
        var tintColor: UIColor = .white
        var backgroundColors: SCSColors = .init()
        var foregroundColors: SCSColors = .init()
        var strokeColors: SCSColors = .init()
    }
}
