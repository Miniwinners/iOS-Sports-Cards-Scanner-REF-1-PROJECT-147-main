import UIKit

extension CommonButton {
    enum SCSButtonStyle {
        case `default`
        case cancel
        case destructive
        case custom(SCSAppearance)
    }
}

extension CommonButton.SCSButtonStyle {
    var configuration: UIButton.Configuration { appearance.configuration }
    var font: UIFont { appearance.font }
    var tintColor: UIColor { appearance.tintColor }

    // MARK: - Background Colors
    var primaryBackgroundColor: UIColor { appearance.backgroundColors.primary }
    var disabledBackgroundColor: UIColor { appearance.backgroundColors.disabled }
    var highlightedBackgroundColor: UIColor { appearance.backgroundColors.highlighted }

    // MARK: - Foreground Colors
    var primaryForegroundColor: UIColor { appearance.foregroundColors.primary }
    var disabledForegroundColor: UIColor { appearance.foregroundColors.disabled }
    var highlightedForegroundColor: UIColor { appearance.foregroundColors.highlighted }

    // MARK: - Stroke Colors
    var primaryStrokeColor: UIColor { appearance.strokeColors.primary }
    var disabledStrokeColor: UIColor { appearance.strokeColors.disabled }
    var highlightedStrokeColor: UIColor { appearance.strokeColors.highlighted }

    private var appearance: CommonButton.SCSAppearance {
        switch self {
        case .default: return Self.defaultAppearance
        case .cancel: return Self.cancelAppearance
        case .destructive: return Self.destructiveAppearance
        case .custom(let appearance): return appearance
        }
    }

    // MARK: - Configurations
    private static let defaultAppearance: CommonButton.SCSAppearance = .init(
        configuration: defaultConfiguration,
        tintColor: .white,
        backgroundColors: .init(primary: .blue, disabled: .blue, highlighted: .blue),
        foregroundColors: .init(primary: .white, disabled: .white, highlighted: .highlightColor)
    )

    private static let cancelAppearance: CommonButton.SCSAppearance = .init(
        configuration: cancelConfiguration,
        foregroundColors: .init(primary: .labelColor, highlighted: .highlightColor),
        strokeColors: .init(primary: .labelColor, disabled: .labelColor, highlighted: .highlightColor)
    )

    private static let destructiveAppearance: CommonButton.SCSAppearance = .init(
        configuration: destructiveConfiguration,
        font: .font(.sfProDisplaySemibold, size: 17),
        tintColor: .destructiveColor,
        backgroundColors: .init(primary: .white, highlighted: .highlightColor2),
        foregroundColors: .init(primary: .destructiveColor, highlighted: .destructiveColor)
    )

    private static let defaultConfiguration: UIButton.Configuration = {
        var configuration: UIButton.Configuration = .filled()
        configuration.background.cornerRadius = 12
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .actionActiveColor
        configuration.baseForegroundColor = .white

        return configuration
    }()

    private static let cancelConfiguration: UIButton.Configuration = {
        var configuration: UIButton.Configuration = .bordered()
        configuration.background.cornerRadius = 12
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .labelColor
        configuration.background.strokeColor = .labelColor
        configuration.background.strokeWidth = 1

        return configuration
    }()

    private static let destructiveConfiguration: UIButton.Configuration = {
        var configuration: UIButton.Configuration = .filled()
        configuration.background.cornerRadius = 14
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .destructiveColor

        return configuration
    }()
}
