import UIKit
import SnapKit

final class CardDetailsListView: UIView {

    private var detailItems: [CardDetailsItem] = []

    private var detailsViewHeightConstraint: Constraint?

    lazy var detailsView: UITableView = { tableView in
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isUserInteractionEnabled = false
        tableView.register(CardDetailsItemTableViewCell.self, forCellReuseIdentifier: CardDetailsItemTableViewCell.className)
        tableView.dataSource = self
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func updateDetailItems(_ detailItems: [CardDetailsItem]) {
        self.detailItems = detailItems
        detailsView.reloadData()
        updateDetailsViewHeight()
    }
}

private extension CardDetailsListView {
    func setupSubviews_unique() {
        backgroundColor = .clear
//        cornerRadius = 12

        addSubview(detailsView)
        detailsView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(4)
            detailsViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func updateDetailsViewHeight() {
        let height = CGFloat(detailItems.count) * CardDetailsItemTableViewCell.cellHeight
        detailsViewHeightConstraint?.update(offset: height)
    }

    func detailItem(at indexPath: IndexPath) -> CardDetailsItem? {
        detailItems[safe: indexPath.row]
    }
}

extension CardDetailsListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return detailItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardDetailsItemTableViewCell.className, for: indexPath) as? CardDetailsItemTableViewCell

        if let item = detailItem(at: indexPath) {
            cell?.setCardDetails(item)
        }
//        cell?.set(cellPosition: UITableView.cellPosition(for: indexPath, basedOn: detailItems))

        return cell ?? UITableViewCell()
    }
}
