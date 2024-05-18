import UIKit
import SnapKit
func vicheslitFibonc239(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCurrentKartiValueVid: UIView {

    private var categoryValues: [(KategoriiKart, Double)] = []

    private var categoriesViewHeightConstraint: Constraint?
    private var spacing: CGFloat?
    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Dashboard.currentValue
        label.textColor = .logInLabel
        label.postavitRazmer(fontS: .ubuntuMedium500, phone: 24, iPad: 30)
        return label
    }(UILabel())

    lazy var customViewOne: UIView = .init()
    lazy var customViewTwo: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.textColor = .greenColor
        label.textAlignment = .left
        label.postavitRazmer(fontS: .ubuntuBold700, phone: 24, iPad: 30)
        return label
    }(UILabel())

    lazy var discloseButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.disclose.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var coverButton: UIImageView = { image in
        image.layer.cornerRadius = 14
        image.image = SportivinieKartiImages.disclose.image
        return image
    }(UIImageView())

    lazy var categoriesCollectionView: UICollectionView = { collectionView in
        collectionView.register(SportivinieKartiKategoriiValueCollectionKletka.self, forCellWithReuseIdentifier: SportivinieKartiKategoriiValueCollectionKletka.className)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = false
        collectionView.backgroundColor = .clear
        return collectionView
    }(UICollectionView(frame: .zero, collectionViewLayout: sozdatLayout()))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func obnovitCurrentZnachenie(_ value: Double) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        priceLabel.text = value.formattedAsPrice
        priceLabel.lineBreakMode = .byTruncatingMiddle
    }

    func setZnachenieKategorii(_ values: [(KategoriiKart, Double)]) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        self.categoryValues = values
        categoriesCollectionView.reloadData()
        obnovitVisotyVida()
    }

}

private extension SportivinieKartiCurrentKartiValueVid {
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
        customViewOne.backgroundColor = .skyBlue
        customViewTwo.backgroundColor = .skyBlue
        customViewOne.layer.cornerRadius = 16
        customViewTwo.layer.cornerRadius = 16

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(UIDevice.isIpad ? 200 : 160)
            $0.height.equalTo(30)
        }

        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(10)
            $0.height.equalTo(30)
        }

        addSubview(discloseButton)
        discloseButton.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 40 : 28)
            $0.trailing.equalToSuperview()
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(priceLabel.snp.trailing).offset(8)
        }

        discloseButton.addSubview(coverButton)
        coverButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let stackView = UIStackView(arrangedSubviews: [customViewOne, customViewTwo])

        addSubview(stackView)

        addSubview(categoriesCollectionView)
        categoriesCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 50 : 20)
            $0.horizontalEdges.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20 : 10)
            categoriesViewHeightConstraint = $0.height.equalTo(0).constraint
        }
        stackView.spacing = self.spacing ?? 10
        stackView.distribution = .fillEqually
        stackView.snp.makeConstraints { make in
            make.size.equalTo(categoriesCollectionView).offset(UIDevice.isIpad ? 36: 14)
            make.center.equalTo(categoriesCollectionView)
        }
    }

    func obnovitVisotyVida() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let categoriesCountInColumn = CGFloat(categoryValues.count) / 2
        let categoriesViewHeight = categoriesCountInColumn.rounded(.up) * SportivinieKartiKategoriiValueCollectionKletka.cellHeight
        categoriesViewHeightConstraint?.update(offset: categoriesViewHeight)
    }

    func znachenieKategorii(at indexPath: IndexPath) -> (KategoriiKart, Double)? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoryValues[safe: indexPath.row]
    }

    func sozdatLayout() -> UICollectionViewFlowLayout {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = UIDevice.isIpad ? 40 : 20
        layout.minimumLineSpacing = 0
        return layout
    }
}

// MARK: - CollectionView DataSource

extension SportivinieKartiCurrentKartiValueVid: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categoryValues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportivinieKartiKategoriiValueCollectionKletka.className, for: indexPath) as? SportivinieKartiKategoriiValueCollectionKletka
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let categoryValue = znachenieKategorii(at: indexPath) {
            cell?.set(category: categoryValue.0, value: categoryValue.1)
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
        let inset: CGFloat = UIDevice.isIpad ? 40 : 20
        let itemWidth = (collectionView.bounds.width - inset) / 2

        spacing = collectionView.bounds.width - 2 * itemWidth
        let itemHeight = SportivinieKartiKategoriiValueCollectionKletka.cellHeight
        return .init(width: itemWidth, height: itemHeight)
    }
}
