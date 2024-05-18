import UIKit
import SnapKit
func vicheslitFibonc333(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiNedavnoDobavKartiVid: UIView {

    weak var delegate: UICollectionViewDelegate?

    private static let itemInRow = 3

    private var recentlyAddedCards: [SportivinieKartiKartaPredstavlenie] = []

    private var cardsViewHeightConstraint: Constraint?

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.recentlyAdded
        label.textColor = .labelColor
        label.postavitRazmer(fontS: .ubuntuMedium500, phone: 24, iPad: 30)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        return button
    }(UIButton(type: .system))

    lazy var coverButton: UIImageView = { image in
        image.layer.cornerRadius = 14
        image.image = SportivinieKartiImages.disclose.image
        return image
    }(UIImageView())

    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.register(SportivinieKartiCardPCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiCardPCollectionKletka.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }(SportivinieKartiBaseCollectionKletka(frame: .zero, collectionViewLayout: sozdatLayout()))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func setRecentlyAddedCards(_ cards: [SportivinieKartiKartaPredstavlenie]) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        self.recentlyAddedCards = cards
        cardsCollectionView.reloadData()
    }

    override func layoutSubviews() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        super.layoutSubviews()
        obnovitVistoyVida()
    }
}

private extension SportivinieKartiNedavnoDobavKartiVid {
    var itemSize: CGSize {
        let layout = cardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let spacing = layout?.minimumInteritemSpacing ?? 0
        let spacings = CGFloat(Self.itemInRow - 1) * spacing

        let collectionViewWidth = cardsCollectionView.bounds.width
        let itemsWidth = collectionViewWidth - spacings
        let itemWidth = itemsWidth / CGFloat(Self.itemInRow)
        let coef = UIDevice.isIpad ? 1.5 : 1.388
        let itemHeight = itemWidth * coef

        return .init(width: itemWidth, height: itemHeight)
    }

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
        backgroundColor = .white
        cornerRadius = 12

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 24 : 16)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 40 : 28)
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview()
        }
        discloseButton.addSubview(coverButton)
        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        addSubview(cardsCollectionView)
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30 : 20)
            $0.horizontalEdges.bottom.equalToSuperview()
            cardsViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func obnovitVistoyVida() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardsViewHeightConstraint?.update(offset: itemSize.height)
    }

    func sozdatLayout() -> UICollectionViewFlowLayout {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = UIDevice.isIpad ? 20 : 12
        layout.minimumLineSpacing = 0
        return layout
    }

    func karta(at indexPath: IndexPath) -> SportivinieKartiKartaPredstavlenie? {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
       return recentlyAddedCards[safe: indexPath.row]
    }
}

extension SportivinieKartiNedavnoDobavKartiVid: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return recentlyAddedCards.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiCardPCollectionKletka.className, for: indexPath) as? SportivinieKartiCardPCollectionKletka
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let card = karta(at: indexPath) {
            cell?.postavitKarty(card)
        }

        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return itemSize
    }

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCollectionKletka
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cell?.sdelatCellVidelenoi(true)
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? SportivinieKartiCardPCollectionKletka
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cell?.sdelatCellVidelenoi(false)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
    }
}
