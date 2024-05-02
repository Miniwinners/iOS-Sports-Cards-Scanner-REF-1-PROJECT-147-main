import UIKit
import SnapKit

final class CardSetView: UIView {
    enum SetType {
        case collection, deck
    }

    let setType: SetType

    // MARK: - Subviews

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.interMedium, size: UIDevice.isIpad ? 22:16)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var descriptionLabel: UILabel = { label in
        label.font = .font(.interMedium, size: UIDevice.isIpad ?18:12)
        label.textColor = .labelColor
        label.text = setType == .collection ? L10n.Portfolio.Collection.description : L10n.Portfolio.Deck.description
        label.setLineHeight(UIDevice.isIpad ?26:22)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interRegular, size: UIDevice.isIpad ?18:12)
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

final class DeckCollectionView: UIView {

    enum SetType {
        case collection
        case deck
    }

    let setType: SetType

    lazy var previewImage: UIImageView = .init()

    lazy var titleCreate: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        return label
    }(UILabel())

    lazy var subtitleCreate: UILabel = { label in
        label.textColor = .singINLabel
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ?18:12)
        return label
    }(UILabel())
    private lazy var containerView: UIView = .init()
    private lazy var plusImageView: UIImageView = .init(image: Images.addPlus.image)
    private lazy var stackView: UIStackView = .init(arrangedSubviews: [previewImage, titleCreate, subtitleCreate, containerView])

    init(setType: SetType) {
        self.setType = setType
        super.init(frame: .zero)
        setupButton()
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

    func setupButton() {

        backgroundColor = .white
        layer.cornerRadius = UIDevice.isIpad ? 30:16
        addSubview(stackView)
        stackView.backgroundColor = .clear
        stackView.spacing = UIDevice.isIpad ?16:8
        stackView.axis = .vertical
        stackView.distribution = .fill
        previewImage.contentMode = .scaleAspectFill
        previewImage.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ? 150:80)
        }
        plusImageView.backgroundColor = .clear

        containerView.addSubview(plusImageView)
        containerView.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ?63:30)
        }
        plusImageView.snp.makeConstraints { make in
            make.size.equalTo(UIDevice.isIpad ? 19:10)
            make.center.equalToSuperview()
        }
        titleCreate.setLineHeight(26)
        subtitleCreate.setLineHeight(22)
        containerView.backgroundColor = .skyBlue
        containerView.layer.cornerRadius = 8

        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?20:10)
            make.verticalEdges.equalToSuperview().inset(UIDevice.isIpad ?20:15)
        }
    }

    func setupForCardSet(_ cardSet: CardCollectible) {
        titleCreate.text = cardSet.name
        titleCreate.numberOfLines = 1
        previewImage.image = setType == .collection ? Images.createDeck.image : Images.createCollection.image
        containerView.isHidden = true
        plusImageView.isHidden = true
    }

    func setupForCreationSet() {
        previewImage.image = setType == .collection ? Images.createDeck.image : Images.createCollection.image
        titleCreate.text = setType == .collection ? L10n.Portfolio.Collection.create : L10n.Portfolio.Deck.create
        titleCreate.numberOfLines = 1
//        titleCreate.setLineHeight(26)
        containerView.isHidden = false
        plusImageView.isHidden = false
    }

}
