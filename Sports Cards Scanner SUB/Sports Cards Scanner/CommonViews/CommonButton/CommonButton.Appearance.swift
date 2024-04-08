import UIKit

extension CommonButton {
    struct SCSAppearance {
        var configuration: UIButton.Configuration = .plain()
        var font: UIFont = .font(.interMedium, size: 18)
        var tintColor: UIColor = .labelColor
        var backgroundColors: SCSColors = .init()
        var foregroundColors: SCSColors = .init()
        var strokeColors: SCSColors = .init()
    }
}
