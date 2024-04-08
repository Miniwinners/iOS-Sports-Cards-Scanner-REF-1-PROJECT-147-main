import UIKit
import SnapKit

final class CardSetView: UIView {
    enum SetType {
        case collection, deck
    }

    let setType: SetType

    // MARK: - Subviews

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var descriptionLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 12)
        label.textColor = .labelColor
        label.text = setType == .collection ? L10n.Portfolio.Collection.description : L10n.Portfolio.Deck.description
        label.setLineHeight(22)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 12)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var imageView: UIImageView = .init()

    private var imageViewTrailingConstraint: Constraint!

    init(setType: SetType) {
        self.setType = setType
        super.init(frame: .zero)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCardSet(_ cardSet: CardCollectible?) {
        if let cardSet = cardSet {
            setupForCardSet(cardSet)
        } else {
            setupForCreationSet()
        }
    }
}

private extension CardSetView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        isUserInteractionEnabled = false

        let topView = UIView()
        topView.addSubviews(titleLabel, cardsNumberLabel, imageView)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            imageViewTrailingConstraint = $0.trailing.equalToSuperview().constraint
        }

        addSubviews(topView, descriptionLabel)
        topView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(44)
        }
        descriptionLabel.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    func setupForCardSet(_ cardSet: CardCollectible) {
        titleLabel.text = cardSet.name
        titleLabel.numberOfLines = 1
        titleLabel.setLineHeight(22)

        let cardsNumber = cardSet.cardIDs.count
        cardsNumberLabel.text = cardsNumber == 1 ? L10n.Portfolio.oneCard : L10n.Portfolio.numberOfCards(cardsNumber)
        cardsNumberLabel.setLineHeight(22)

        imageView.image = setType == .collection ? Images.collection.image : Images.deck.image
        imageViewTrailingConstraint.update(inset: 11)
    }

    func setupForCreationSet() {
        titleLabel.text = setType == .collection ? L10n.Portfolio.Collection.create : L10n.Portfolio.Deck.create
        titleLabel.numberOfLines = 2
        titleLabel.setLineHeight(22)

        cardsNumberLabel.text = nil

        imageView.image = Images.addSet.image
        imageViewTrailingConstraint.update(inset: 0)
    }
}
