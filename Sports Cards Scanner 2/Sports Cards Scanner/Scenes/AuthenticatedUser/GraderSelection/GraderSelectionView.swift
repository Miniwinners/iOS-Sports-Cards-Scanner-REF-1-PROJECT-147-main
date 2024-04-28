import UIKit
import SnapKit

final class GraderSelectionView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var grabberView: SCSGrabberView = .init()

    lazy var gradersTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = UIDevice.isIpad ? 72:50
        tableView.rowHeight = UIDevice.isIpad ? 72:50
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = .skyBlue
        tableView.isScrollEnabled = false
        return tableView
    }(UITableView())

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(CommonButton(style: .destructive))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

}

private extension GraderSelectionView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        layer.cornerRadius = 20

        addSubview(grabberView)
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.centerX.equalToSuperview()
        }

        addSubview(gradersTableView)
        gradersTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }

//        addSubview(cancelButton)
//        cancelButton.snp.makeConstraints {
//            $0.top.equalTo(gradersTableView.snp.bottom).offset(10)
//            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
//            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20).priority(.high)
//            $0.height.equalTo(56)
//        }
    }
}
