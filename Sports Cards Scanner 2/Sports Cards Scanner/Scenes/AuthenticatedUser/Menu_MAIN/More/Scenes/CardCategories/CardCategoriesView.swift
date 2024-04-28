import UIKit
import SnapKit

final class CardCategoriesView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()
    let containerView = UIView()
    let containerImage = UIView()

    lazy var descriptionImage: UIImageView = { image in
        image.image = Images.deckSign.image
        return image
    }(UIImageView())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.CardCategories.description
        label.setSize(fontS: .ubuntuLight300, phone: 16, iPad: 24)
        label.textColor = .logInLabel
        label.numberOfLines = 0
        label.setLineHeight(UIDevice.isIpad ? 24 : 28)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var imageLabelStack: UIStackView = { stackView in
        stackView.spacing = UIDevice.isIpad ? 20:5
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }(UIStackView(arrangedSubviews: [containerImage, descriptionLabel]))

    lazy var checkSignImageView: UIImageView = { image in
        image.image = Images.checkSign.image
        return image
    }(UIImageView())

    lazy var tableView: UITableView = { tableView in
        tableView.rowHeight = UIDevice.isIpad ? 80 : UITableView.automaticDimension
        tableView.estimatedRowHeight = UIDevice.isIpad ? 85 : 74
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.top = 20
        tableView.contentInset.bottom = 20
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .clear
        return tableView
    }(UITableView())

    lazy var minEnabledCategoriesLabel: UILabel = { label in
        label.text = L10n.CardCategories.minEnabledCategories
        label.setSize(fontS: .ubuntuLight300, phone: 14, iPad: 20)
        label.textColor = .singINLabel
        label.numberOfLines = 0
        label.setLineHeight(UIDevice.isIpad ? 22 : 20)
        label.textAlignment = .center
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .clear
        setupSubviews_unique()
    }
}

private extension CardCategoriesView {
    func setupSubviews_unique() {
        let checkSignView = UIView()

        containerView.backgroundColor = .skyBlue
        containerView.cornerRadius = UIDevice.isIpad ? 24:16

        backView.setupView(in: self)
        titleLabel.setupLabel(in: backView)
        backView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40 : 20)
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 90 : 20)
            make.height.greaterThanOrEqualTo(UIDevice.isIpad ? 190 : 120)
        }

        containerView.addSubview(imageLabelStack)
        imageLabelStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIDevice.isIpad ? 40 : 20)
        }

        containerImage.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ? 60 : 30)
        }
        containerImage.addSubview(descriptionImage)

        descriptionImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(UIDevice.isIpad ? 40 : 30)
            make.width.equalTo(UIDevice.isIpad ? 58 : 44)
        }

        backView.addSubview(tableView)
        backView.addSubview(checkSignView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(checkSignView.snp.bottom).offset(UIDevice.isIpad ? 25:5)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        checkSignView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(UIDevice.isIpad ? 30:20)
            make.height.equalTo(UIDevice.isIpad ? 36 : 20)
            make.horizontalEdges.equalTo(tableView).inset(UIDevice.isIpad ? 140 : 80)
            make.centerX.equalToSuperview()
//            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 40 : 20)
        }

        checkSignView.addSubviews(minEnabledCategoriesLabel, checkSignImageView)

        minEnabledCategoriesLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        checkSignImageView.snp.makeConstraints { make in
            make.size.equalTo(UIDevice.isIpad ? 34 : 20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(5)
        }

    }

}
