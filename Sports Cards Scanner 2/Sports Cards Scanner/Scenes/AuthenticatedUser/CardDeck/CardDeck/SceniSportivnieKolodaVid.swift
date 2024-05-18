import UIKit
import SnapKit
func vicheslitFibonc263(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKolodaVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var menuButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.menuDots.image, for: .normal)
        button.tintColor = .black
        return button
    }(UIButton(type: .system))

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22: 16)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var nameSecondaryLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?28:22)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        label.textColor = .greenColor
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var collectionCards: UICollectionView = { collection in
        collection.backgroundColor = .clear
        return collection
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    lazy var noCardsView: SportivinieKartiCustomMessageVid = { view in
        view.postavitZagolovok(L10n.CardDeck.noCards)
        return view
    }(SportivinieKartiCustomMessageVid())

    lazy var addCardsButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.CardDeck.Action.addCards)
        return button
    }(SportivinieKartiCommonKnopka(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func setDeck(name: String?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = name
        nameSecondaryLabel.text = name
        nameSecondaryLabel.setVisotaLabla(UIDevice.isIpad ? 28:22)
    }

    func setKarti(count: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch count {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(count)
        }
        cardsNumberLabel.setVisotaLabla(UIDevice.isIpad ? 28:22)

        noCardsView.isHidden = count != 0
        addCardsButton.isHidden = count != 0
    }

    func setKarti(price: Double) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        priceLabel.text = price.formattedAsPrice
    }

}

private extension SportivinieKartiKolodaVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        backView.postavitVid(in: self)

        titleLabel.postavitLabel(in: backView)

        addSubviews(menuButton, cardsNumberLabel, nameSecondaryLabel, priceLabel, collectionCards, noCardsView, addCardsButton)

        cardsNumberLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 34:14)
            $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        nameSecondaryLabel.snp.makeConstraints {
            $0.top.equalTo(cardsNumberLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(cardsNumberLabel)
            $0.leading.equalTo(cardsNumberLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        collectionCards.snp.makeConstraints {
            $0.top.equalTo(nameSecondaryLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 60:0)
        }
        noCardsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        addCardsButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
        }
        menuButton.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 60:44)
            $0.centerY.equalTo(nameSecondaryLabel)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 65:30)
            $0.leading.equalTo(nameSecondaryLabel.snp.trailing).offset(8)
        }
    }
}

extension SportivinieKartiKolodaVid {
    func filterLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(
            widthDimension: .estimated(UIDevice.isIpad ? 253:162),
            heightDimension: .absolute(UIDevice.isIpad ? 464:317)
        )

        let item = NSCollectionLayoutItem(layoutSize: size)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(UIDevice.isIpad ? 464:317))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: UIDevice.isIpad ? 3:2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(
            top: 0,
            leading: 16,
            bottom: 0,
            trailing: 16
        )

        return UICollectionViewCompositionalLayout(section: section)
    }
}
