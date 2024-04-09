import UIKit
import SnapKit

final class CardCategoryButton: UIButton {

    var cardCategory: CardCategory? {
        didSet { categoryLabel.text = cardCategory?.title ?? "" }
    }

    lazy var categoryLabel: UILabel = { label in
        label.text = cardCategory?.title ?? ""
        label.textColor = .black
        label.font = .font(.ubuntuRegular400, size: 16)
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = .init(image: Images.disclosureBottom.image)

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConfiguration() {
        switch state {
        case .highlighted:
            categoryLabel.textColor = .highlightColor
            disclosureImageView.tintColor = .highlightColor
        default:
            categoryLabel.textColor = .black
            disclosureImageView.tintColor = .black
        }
    }

}

private extension CardCategoryButton {
    func setupSubviews_unique() {
        let leftSpacer = UIView()
        let rightSpacer = UIView()

        configuration = .plain()
        disclosureImageView.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }
        leftSpacer.snp.makeConstraints { $0.width.equalTo(10) }
        rightSpacer.snp.makeConstraints { $0.width.equalTo(5) }
        let stackView = UIStackView(arrangedSubviews: [leftSpacer, categoryLabel, disclosureImageView, rightSpacer])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false
        stackView.spacing = 10
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
