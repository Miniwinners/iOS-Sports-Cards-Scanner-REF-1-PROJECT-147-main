import UIKit
import SnapKit

final class MenuView: UIView {

    lazy var menuTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 70
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

private extension MenuView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        addSubviews(menuTableView, cancelButton)
        menuTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(34)
            $0.horizontalEdges.equalToSuperview()
        }
        cancelButton.snp.makeConstraints {
            $0.top.equalTo(menuTableView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20).priority(.high)
            $0.height.equalTo(56)
        }
    }
}
