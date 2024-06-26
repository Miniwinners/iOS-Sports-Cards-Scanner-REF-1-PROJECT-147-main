import UIKit

extension UITabBar {
    func applyDefaultAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .clear

        let normalItemAppearance = UITabBarItemAppearance()
        normalItemAppearance.normal.titleTextAttributes = [.font: UIFont.font(.ubuntuBold700, size: UIDevice.isIpad ? 18 : 12)]
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
        let posY: CGFloat = UIDevice.isIpad ? 35 : 20
        let width = bounds.width
        let height = bounds.height + posY * 2.6

        let roundLayer = CAShapeLayer()

        let bezierPath = UIBezierPath(roundedRect: CGRect(x: posX, y: bounds.minY - posY, width: width, height: height),
                                      cornerRadius: UIDevice.isIpad ? 40 : height/2)
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
        itemPositioning = .centered

        roundLayer.fillColor = UIColor.white.cgColor
    }

    open override var traitCollection: UITraitCollection {
        if UIDevice.isIpad {
//            if #available(iOS 17.0, *) {
//                self.traitOverrides.horizontalSizeClass = .compact
//                self.traitOverrides.verticalSizeClass = .compact
//            } else {
                return UITraitCollection(horizontalSizeClass: .compact)
//            }
        }
        return super.traitCollection
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
