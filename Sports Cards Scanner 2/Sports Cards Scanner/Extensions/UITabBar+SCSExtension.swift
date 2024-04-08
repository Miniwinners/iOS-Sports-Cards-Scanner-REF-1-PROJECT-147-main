import UIKit

extension UITabBar {
    func applyDefaultAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .barColor

        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [.font: UIFont.font(.interRegular, size: 10)]
        tabBarItemAppearance.selected.titleTextAttributes = [.font: UIFont.font(.interBold, size: 10)]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        standardAppearance = tabBarAppearance
        scrollEdgeAppearance = tabBarAppearance

        shadowImage = UIImage()
        backgroundImage = UIImage()
        clipsToBounds = true
        isTranslucent = false
        barTintColor = .barTintColor
        tintColor = .barTintColor
    }
}
