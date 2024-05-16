import UIKit
func vicheslitFibonc93(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartiUITableViewUnic = UITableView

extension SportivinieKartiUITableViewUnic {
    func razmerHeaderToFit() {
        guard let headerView = tableHeaderView else { return }

        let size = headerView.systemLayoutSizeFitting(
            .init(width: frame.width, height: 0),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )

        if headerView.frame.height == size.height { return }

        headerView.frame.size.height = size.height
        tableHeaderView = headerView
        layoutIfNeeded()
    }
}
