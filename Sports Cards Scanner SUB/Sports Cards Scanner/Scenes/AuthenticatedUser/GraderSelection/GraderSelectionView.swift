import UIKit
import SnapKit

final class GraderSelectionView: UIView {

    lazy var grabberView: SCSGrabberView = .init()

    lazy var gradersTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 56
        tableView.rowHeight = 56
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
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
        backgroundColor = .backColor

        addSubview(grabberView)
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.centerX.equalToSuperview()
        }

        addSubview(gradersTableView)
        gradersTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.horizontalEdges.equalToSuperview()
        }

        addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(gradersTableView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20).priority(.high)
            $0.height.equalTo(56)
        }
    }
}
