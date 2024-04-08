import UIKit
import SnapKit

final class SCSMoreView: UIView {

    lazy var profileLogoView: UIImageView = .init(image: Images.profileLogo.image)

    lazy var tableView: UITableView = { tableView in
        tableView.backgroundColor = .backColor
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)

        backgroundColor = .backColor
        setupSubviews_unique()
    }

}

private extension SCSMoreView {

    func setupSubviews_unique() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        let headerView = UIView()
        headerView.frame.size.height = 146
        headerView.addSubview(profileLogoView)

        profileLogoView.snp.makeConstraints {
            $0.size.equalTo(109)
            $0.top.equalToSuperview().inset(7)
            $0.bottom.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
        }

        tableView.tableHeaderView = headerView
    }

}
