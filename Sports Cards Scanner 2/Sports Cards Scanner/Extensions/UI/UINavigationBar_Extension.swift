import UIKit

extension UINavigationBar {
    func applyDefaultAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.shadowColor = .clear
        navBarAppearance.titleTextAttributes = [
            .font: UIFont.font(.ubuntuMedium500, size: 20),
            .foregroundColor: UIColor.labelColor
        ]

        standardAppearance = navBarAppearance
        scrollEdgeAppearance = navBarAppearance
        compactAppearance = navBarAppearance
        compactScrollEdgeAppearance = navBarAppearance
    }
}
