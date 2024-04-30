import UIKit
import SnapKit

final class HighestCardsValueView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.highestValue
        label.textColor = .black
        label.setSize(fontS: .ubuntuMedium500, phone: 24, iPad: 30)
        label.setLineHeight(UIDevice.isIpad ? 32 : 28)
        return label
    }(UILabel())

    lazy var numOneImage: UIImageView = .init(image: Images.highValue1.image)
    lazy var numTwoImage: UIImageView = .init(image: Images.highValue2.image)
    lazy var numThreeImage: UIImageView = .init(image: Images.highValue3.image)

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .horizontal
        stackView.spacing = UIDevice.isIpad ? 20 : 10
        stackView.distribution = .fillEqually
        return stackView
    }(UIStackView(arrangedSubviews: [cardButton, cardButtonTwo, cardButtonThree]))

    lazy var discloseButton: UIButton = { button in
        return button
    }(UIButton(type: .system))

    lazy var coverButton: UIImageView = { image in
        image.layer.cornerRadius = 14
        image.image = Images.disclose.image
        return image
    }(UIImageView())

//    lazy var highestValueCollection: UICollectionView = { collection in
//        collection.backgroundColor = .clear
//        return collection
//    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    lazy var cardButton: CommonButton = .init(style: .custom(createCardButtonAppearance()))
    lazy var cardButtonTwo: CommonButton = .init(style: .custom(createCardButtonAppearance()))
    lazy var cardButtonThree: CommonButton = .init(style: .custom(createCardButtonAppearance()))

    lazy var cardView: CardView = .init()
    lazy var cardViewTwo: CardView = .init()
    lazy var cardViewThree: CardView = .init()
    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCard(_ card: CardRepresentable, _ cardTwo: CardRepresentable, _ cardThree: CardRepresentable) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardView.setCard(card)
        cardViewTwo.setCard(cardTwo)
        cardViewThree.setCard(cardThree)
    }

}

private extension HighestCardsValueView {
    func setupSubviews_unique() {
        if UIDevice.isIpad { setupIpad()
        } else if UIDevice.isIphone { setupPhone()
        }
    }

    func setupPhone() {
        cardButtonThree.isHidden = true
        backgroundColor = .white
        cornerRadius = 12
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(28)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
        }

        discloseButton.addSubview(coverButton)
        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        cardButton.addSubview(cardView)

        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        cardView.isUserInteractionEnabled = false
        cardView.setCardsNumber(1)

        cardButtonTwo.addSubview(cardViewTwo)
        cardViewTwo.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        cardViewTwo.isUserInteractionEnabled = false
        cardViewTwo.setCardsNumber(2)

        cardButton.addSubview(numOneImage)
        numOneImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(25)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
        cardButtonTwo.addSubview(numTwoImage)
        numTwoImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(25)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }

    func setupIpad() {
        cardButtonThree.isHidden = false

        backgroundColor = .white
        cornerRadius = 12
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
        }

        discloseButton.addSubview(coverButton)
        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        cardButton.addSubview(cardView)

        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        cardView.isUserInteractionEnabled = false
        cardView.setCardsNumber(1)

        cardButtonTwo.addSubview(cardViewTwo)
        cardViewTwo.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        cardViewTwo.isUserInteractionEnabled = false
        cardViewTwo.setCardsNumber(2)

        cardButton.addSubview(numOneImage)
        numOneImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(25)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
        cardButtonTwo.addSubview(numTwoImage)

        cardButtonThree.addSubview(cardViewThree)
        cardViewThree.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
        cardViewThree.isUserInteractionEnabled = false
        cardViewThree.setCardsNumber(3)
        cardButtonThree.addSubview(numThreeImage)
        numThreeImage.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.width.equalTo(25)
            $0.top.equalToSuperview()
            $0.right.equalToSuperview().inset(20)
        }

        numTwoImage.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.width.equalTo(25)
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        }
    }

    private func createCardButtonAppearance() -> CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 16
        return .init(configuration: configuration, backgroundColors: .init(primary: .skyBlue, highlighted: .highlightColor2))
    }

//    private func filterLayout() -> UICollectionViewCompositionalLayout {
//        let size = NSCollectionLayoutSize(
//            widthDimension: .estimated(UIDevice.isIpad ? 252 : 162),
//            heightDimension: .absolute(UIDevice.isIpad ? 464 : 297)
//        )
//
//        let item = NSCollectionLayoutItem(layoutSize: size)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 464 : 297))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3 : 2)
//        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10
//        section.contentInsets = .init(
//            top: 0,
//            leading: 16,
//            bottom: 0,
//            trailing: 16
//        )
//
//        return UICollectionViewCompositionalLayout(section: section)
//    }

}
