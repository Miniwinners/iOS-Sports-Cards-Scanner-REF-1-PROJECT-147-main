import UIKit

extension UITabBar {
    func applyDefaultAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .clear

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

        let posX: CGFloat = 0
        let posY: CGFloat = 20
        let width = bounds.width
        let height = bounds.height + posY * 2.6

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(roundedRect: CGRect(x: posX, y: bounds.minY - posY, width: width, height: height),
                                      cornerRadius: height/2)
        roundLayer.path = bezierPath.cgPath

        layer.insertSublayer(roundLayer, at: 0)

        standardAppearance = tabBarAppearance
        scrollEdgeAppearance = tabBarAppearance
        shadowImage = UIImage()
        backgroundImage = UIImage()
        barTintColor = .barTintColor
        tintColor = .barTintColor
        isTranslucent = true
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 0.2
        layer.shadowColor = UIColor.lightGray.cgColor

        roundLayer.fillColor = UIColor.white.cgColor
    }
}

extension UITabBarController {

    func setupCustomTabBarView() {
        let customView = UIView()
        customView.backgroundColor = .white
        customView.layer.cornerRadius = 10
        customView.layer.masksToBounds = true
                customView.frame = CGRect(x: 0, y: tabBar.frame.size.height - 20, width: tabBar.frame.size.width, height: 100)
                customView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
                tabBar.addSubview(customView)
                tabBar.sendSubviewToBack(customView)
    }

}
