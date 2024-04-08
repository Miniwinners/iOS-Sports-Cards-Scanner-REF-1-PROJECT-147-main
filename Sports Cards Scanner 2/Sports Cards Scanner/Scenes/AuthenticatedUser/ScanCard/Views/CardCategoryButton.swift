import UIKit
import SnapKit

final class CardCategoryButton: UIButton {

    var cardCategory: CardCategory? {
        didSet { categoryLabel.text = cardCategory?.title ?? "" }
    }

    lazy var categoryLabel: UILabel = { label in
        label.text = cardCategory?.title ?? ""
        label.textColor = .white
        label.font = .font(.interRegular, size: 16)
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = .init(image: Images.disclosureBottom.image)

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .white
        return view
    }(UIView())

    init() {
        super.init(frame: .zero)

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
            categoryLabel.textColor = .white
            disclosureImageView.tintColor = .white
        }
    }

}

private extension CardCategoryButton {
    func setupSubviews_unique() {
        configuration = .plain()

        disclosureImageView.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }

        let stackView = UIStackView(arrangedSubviews: [categoryLabel, disclosureImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
