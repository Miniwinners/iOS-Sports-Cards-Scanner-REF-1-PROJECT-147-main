import UIKit
import SnapKit

final class CardGraderButton: UIButton {

    var cardGrader: CardGrader? {
        didSet { graderLabel.text = cardGrader?.rawValue ?? "" }
    }

    lazy var graderLabel: UILabel = { label in
        label.text = cardGrader?.rawValue ?? ""
        label.textColor = .labelColor
        label.font = .font(.interRegular, size: 16)
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = { imageView in
        imageView.tintColor = .labelColor4
        return imageView
    }(UIImageView(image: Images.disclosureBottom.image))

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
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
            graderLabel.textColor = .highlightColor
            disclosureImageView.tintColor = .highlightColor2
        default:
            graderLabel.textColor = .labelColor
            disclosureImageView.tintColor = .labelColor4
        }
    }

}

private extension CardGraderButton {
    func setupSubviews_unique() {
        configuration = .plain()

        disclosureImageView.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }

        let stackView = UIStackView(arrangedSubviews: [graderLabel, disclosureImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(10)
        }

        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
