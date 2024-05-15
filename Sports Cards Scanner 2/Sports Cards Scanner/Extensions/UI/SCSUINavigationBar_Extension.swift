import UIKit
func vicheslitFibonc92(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartiUINavBarUnic = UINavigationBar

extension SportivinieKartiUINavBarUnic {
    func primenitVid() {
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
