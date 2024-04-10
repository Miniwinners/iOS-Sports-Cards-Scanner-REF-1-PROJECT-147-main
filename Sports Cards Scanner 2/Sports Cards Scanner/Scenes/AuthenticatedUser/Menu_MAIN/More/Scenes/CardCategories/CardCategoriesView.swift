import UIKit
import SnapKit

final class CardCategoriesView: UIView {

    lazy var tableView: UITableView = { tableView in
        tableView.backgroundColor = .backColor
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 66
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = 20
        tableView.contentInset.bottom = 20
        return tableView
    }(UITableView())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.CardCategories.description
        label.font = .font(.interMedium, size: 14)
        label.textColor = .labelColor
        label.numberOfLines = 0
        label.setLineHeight(17)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var minEnabledCategoriesLabel: UILabel = { label in
        label.text = L10n.CardCategories.minEnabledCategories
        label.font = .font(.interRegular, size: 12)
        label.textColor = .labelColor4
        label.numberOfLines = 0
        label.setLineHeight(14.5)
        label.textAlignment = .center
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)

        backgroundColor = .backColor
        setupSubviews_unique()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTableFooterView()
    }
}

private extension CardCategoriesView {
    func setupSubviews_unique() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        let tableFooterView = UIView()
        tableFooterView.addSubviews(descriptionLabel, minEnabledCategoriesLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        minEnabledCategoriesLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        tableView.tableFooterView = tableFooterView
    }

    func layoutTableFooterView() {
        guard let footerView = tableView.tableFooterView else { return }

        let targetSize = CGSize(width: tableView.bounds.width, height: 0)
        let footerSize = footerView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
        footerView.bounds.size = footerSize
    }
}
