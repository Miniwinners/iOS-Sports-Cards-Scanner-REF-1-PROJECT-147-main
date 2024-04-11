import UIKit
import SnapKit

final class CardCategoriesView: UIView {

    lazy var backView: UIView = { view in
        view.setupBackView()
        return view
    }(UIView())

    lazy var containerView: UIView = { view in
        return view
    }(UIView())

    lazy var checkSignImageView: UIImageView = { image in
        image.image = Images.checkSign.image
        return image
    }(UIImageView())

    lazy var descriptionImage: UIImageView = { image in
        image.image = Images.deckSign.image
        return image
    }(UIImageView())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.CardCategories.description
        label.font = .font(.ubuntuLight300, size: 16)
        label.textColor = .logInLabel
        label.numberOfLines = 0
        label.setLineHeight(20)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var imageLabelStack: UIStackView = { stackView in
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }(UIStackView())

    lazy var tableView: UITableView = { tableView in
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 66
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = 20
        tableView.contentInset.bottom = 20
        return tableView
    }(UITableView())

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
        backgroundColor = .clear
        setupSubviews_unique()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTableFooterView()
    }
}

private extension CardCategoriesView {
    func setupSubviews_unique() {
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        containerView.addSubview(imageLabelStack)
        imageLabelStack.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(5)
        }
        imageLabelStack.addSubviews(descriptionImage, descriptionLabel)
        descriptionImage.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(44)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        backView.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        let headerView = UIView()
        headerView.addSubview(minEnabledCategoriesLabel)

        minEnabledCategoriesLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        tableView.tableHeaderView = headerView
    }

    func layoutTableFooterView() {
        guard let headerView = tableView.tableHeaderView else { return }

        let targetSize = CGSize(width: tableView.bounds.width, height: 0)
        let headerSize = headerView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .defaultLow
        )
        headerView.bounds.size = headerSize
        tableView.tableHeaderView = headerView
    }

}
