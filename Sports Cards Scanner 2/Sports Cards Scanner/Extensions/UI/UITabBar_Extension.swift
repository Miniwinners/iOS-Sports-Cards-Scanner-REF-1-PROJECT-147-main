import UIKit

extension UITabBar {
    func applyDefaultAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.backgroundColor = .white

        let normalItemAppearance = UITabBarItemAppearance()
        normalItemAppearance.normal.titleTextAttributes = [.font: UIFont.font(.ubuntuMedium500, size: 12)]
        normalItemAppearance.normal.iconColor = .singINLabel

        let selectedItemAppearance = UITabBarItemAppearance()
        selectedItemAppearance.selected.titleTextAttributes = [.font: UIFont.font(.ubuntuMedium500, size: 0)]
        selectedItemAppearance.selected.iconColor = .blue

        tabBarAppearance.stackedLayoutAppearance = normalItemAppearance
        tabBarAppearance.inlineLayoutAppearance = normalItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = normalItemAppearance

        tabBarAppearance.stackedLayoutAppearance = selectedItemAppearance
        tabBarAppearance.inlineLayoutAppearance = selectedItemAppearance
        tabBarAppearance.compactInlineLayoutAppearance = selectedItemAppearance

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

extension UITabBarController {

    func setupCustomTabBarView() {
        let customView = UIView()
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 10
        customView.layer.masksToBounds = true
        customView.frame = CGRect(x: 0, y: tabBar.frame.size.height - 50, width: tabBar.frame.size.width, height: 100)
        customView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        tabBar.addSubview(customView)
        tabBar.sendSubviewToBack(customView)
    }

}
