import UIKit

extension UITableView {
    func sizeTableViewHeaderToFit() {
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

//    static func cellPosition<T: Collection>(for indexPath: IndexPath, basedOn collection: T) -> CellPosition {
//        let isFirst = indexPath.row == 0
//        let isLast = indexPath.row == collection.count - 1
//
//        var position: CellPosition = .init()
//        if isFirst { position.insert_unique(.onTopPosition) }
//        if isLast { position.insert_unique(.atBottomPosition) }
//        if !isFirst && !isLast { position.insert_unique(.inMiddlePosition) }
//
//        return position
//    }
}
