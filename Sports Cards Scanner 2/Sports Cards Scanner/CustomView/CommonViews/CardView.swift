import UIKit
import SnapKit
import Kingfisher

final class CardView: UIView {

    static let viewHeight: CGFloat = 297

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: 16)
        label.numberOfLines = 1
        return label
    }(UILabel())

    lazy var subtitleLabel: UILabel = { label in
        label.textColor = .singINLabel
        label.font = .font(.ubuntuMedium500, size: 12)
        label.numberOfLines = 2
        return label
    }(UILabel())

    lazy var cardImageView: UIImageView = { imageView in
        imageView.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var missingImageLabel: UILabel = { label in
        label.text = L10n.Card.missingImage
        label.setLineHeight(19)
        label.textColor = .labelColor3
        label.font = .font(.interRegular, size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var missingImageView: UIView = { view in
        view.cornerRadius = 12
        view.backgroundColor = .black
        return view
    }(UIView())

    lazy var checkedView: UIView = { view in
        view.backgroundColor = .blackColor40
        view.cornerRadius = 12
        view.isHidden = true
        return view
    }(UIView())

    lazy var numberLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 14)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var numberView: UIView = { view in
        view.cornerRadius = 16
        view.backgroundColor = .cardBackColor
        return view
    }(UIView())

    lazy var pricesLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 16)
        label.textColor = .greenColor
        return label
    }(UILabel())

    private var pricesLeadingConstraint: Constraint?
    private var pricesTrailingConstraint: Constraint?
    private var numberPricesSpaceConstraint: Constraint?

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
        setCardsNumber(nil)
    }

    func resetView() {
        missingImageLabel.isHidden = false
        cardImageView.kf.cancelDownloadTask()
        cardImageView.kf.setImage(with: URL(string: ""))
        cardImageView.image = nil
    }

    func setCard(_ card: CardRepresentable) {
        titleLabel.text = card.title
        titleLabel.setLineHeight(22)
        subtitleLabel.text = card.subtitle
        subtitleLabel.setLineHeight(22)
        if let price = card.customPrice {
            pricesLabel.text = price.formattedAsPrice
        } else {
            pricesLabel.text = card.priceRange(of: card.selectedGrader)
        }
        pricesLabel.setLineHeight(22)
        pricesLabel.lineBreakMode = .byTruncatingMiddle
        pricesLabel.textAlignment = .left

        if let imageURL = card.imageURL {
            missingImageLabel.isHidden = true
            cardImageView.kf.setImage(with: imageURL)
        }
    }

    func setChecked(_ checked: Bool) {
        checkedView.isHidden = !checked
    }

    func setCardsNumber(_ number: Int?) {
        numberView.isHidden = number.isNil
        if let number = number {
            numberLabel.text = "#\(number)"
            pricesLeadingConstraint?.deactivate()
            pricesTrailingConstraint?.activate()
            numberPricesSpaceConstraint?.activate()
        } else {
            pricesLeadingConstraint?.activate()
            pricesTrailingConstraint?.deactivate()
            numberPricesSpaceConstraint?.deactivate()
        }
    }

}

private extension CardView {
    func setupSubviews_unique() {
        backgroundColor = .clear

        let checkedImageView = UIImageView(image: Images.cardCheck.image)
        checkedView.addSubview(checkedImageView)
        checkedImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        addSubviews(cardImageView, titleLabel, subtitleLabel, pricesLabel, missingImageView, checkedView, numberView)

        self.snp.makeConstraints {
            $0.height.equalTo(Self.viewHeight)
        }
        cardImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(195)
            $0.width.equalTo(138)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(cardImageView.snp.bottom).offset(5)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
        }
        pricesLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        missingImageView.snp.makeConstraints {
            $0.edges.equalTo(cardImageView)
        }
        checkedView.snp.makeConstraints {
            $0.edges.equalTo(cardImageView)
        }

        missingImageView.addSubview(missingImageLabel)
        missingImageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        numberView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
