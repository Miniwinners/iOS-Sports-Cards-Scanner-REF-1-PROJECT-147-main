import UIKit
func vicheslitFibonc324(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiCommonKnopka {
    enum SportivinieKartistilKnopki {
        case `default`
        case cancel2
        case cancel
        case destructive
        case custom(SportivinieKartiVidKnopki)
    }
}

extension SportivinieKartiCommonKnopka.SportivinieKartistilKnopki {
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

    private var appearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki {
        switch self {
        case .cancel2: return Self.cancel2Appearance
        case .default: return Self.defaultAppearance
        case .cancel: return Self.cancelAppearance
        case .destructive: return Self.destructiveAppearance
        case .custom(let appearance): return appearance
        }
    }

    // MARK: - Configurations
    private static let defaultAppearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki = .init(
        configuration: defaultConfiguration,
        font: .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22: 16), tintColor: .white,
        backgroundColors: .init(primary: UIColor(red: 0, green: 89/255, blue: 231/255, alpha: 1), disabled: .actionInactiveColor, highlighted: .actionActiveColor),
        foregroundColors: .init(primary: .white, disabled: .white, highlighted: .highlightColor)
    )

    private static let cancel2Appearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki = .init(
        configuration: cancelConfiguration,
        font: .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22 : 16),
        foregroundColors: .init(primary: .red, highlighted: .highlightColor),
        strokeColors: .init(primary: .blue, disabled: .labelColor, highlighted: .highlightColor)
    )

    private static let cancelAppearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki = .init(
        configuration: cancelConfiguration,
        font: .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22 : 16),
        foregroundColors: .init(primary: .labelColor, highlighted: .highlightColor),
        strokeColors: .init(primary: .blue, disabled: .labelColor, highlighted: .highlightColor)
    )

    private static let destructiveAppearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki = .init(
        configuration: destructiveConfiguration,
        font: .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22 : 16),
        tintColor: .destructiveColor,
        backgroundColors: .init(primary: .white, highlighted: .highlightColor2),
        foregroundColors: .init(primary: .destructiveColor, highlighted: .destructiveColor)
    )

    private static let defaultConfiguration: UIButton.Configuration = {
        var configuration: UIButton.Configuration = .filled()
        configuration.background.cornerRadius = UIDevice.isIpad ? 24 : 12
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .actionActiveColor
        configuration.baseForegroundColor = .white

        return configuration
    }()

    private static let cancelConfiguration: UIButton.Configuration = {
        var configuration: UIButton.Configuration = .bordered()
        configuration.background.cornerRadius = UIDevice.isIpad ? 24 : 12
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .labelColor
        configuration.background.strokeColor = .labelColor
        configuration.background.strokeWidth = 1

        return configuration
    }()

    private static let destructiveConfiguration: UIButton.Configuration = {
        var configuration: UIButton.Configuration = .filled()
        configuration.background.cornerRadius = UIDevice.isIpad ? 24 : 14
        configuration.cornerStyle = .fixed
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .destructiveColor

        return configuration
    }()
}
