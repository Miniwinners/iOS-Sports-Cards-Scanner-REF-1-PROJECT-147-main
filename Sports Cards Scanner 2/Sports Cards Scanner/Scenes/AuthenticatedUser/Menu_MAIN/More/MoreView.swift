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
        let headerView = UIView()
        headerView.addSubview(profileLogoView)

        if UIDevice.isIphone {
            tableView.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide)
                $0.horizontalEdges.equalToSuperview()
                $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            }

            headerView.frame.size.height = 140

            profileLogoView.snp.makeConstraints {
                $0.size.equalTo(109)
                $0.top.equalToSuperview().inset(7)
                $0.centerX.equalToSuperview()
            }

        } else if UIDevice.isIpad {
            tableView.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide).inset(30)
                $0.horizontalEdges.equalToSuperview().inset(60)
                $0.bottom.equalTo(safeAreaLayoutGuide).inset(40)
            }
            headerView.frame.size.height = 260

            profileLogoView.snp.makeConstraints {
                $0.size.equalTo(197)
                $0.top.equalToSuperview().inset(27)
                $0.centerX.equalToSuperview()
            }
        }
        tableView.tableHeaderView = headerView

    }

}
