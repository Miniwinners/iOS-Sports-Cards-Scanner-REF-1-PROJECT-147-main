import UIKit
import SnapKit

final class MoreView: UIView {

    lazy var profileLogoView: UIImageView = .init(image: Images.profileLogo.image)

    lazy var tableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 3
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)

        backgroundColor = .skyBlue
        setupSubviews_unique()
    }

}

private extension MoreView {

    func setupSubviews_unique() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }

        let headerView = UIView()
        headerView.frame.size.height = 140
        headerView.addSubview(profileLogoView)

        profileLogoView.snp.makeConstraints {
            $0.size.equalTo(109)
            $0.top.equalToSuperview().inset(7)
            $0.centerX.equalToSuperview()
        }

        tableView.tableHeaderView = headerView
    }

}
