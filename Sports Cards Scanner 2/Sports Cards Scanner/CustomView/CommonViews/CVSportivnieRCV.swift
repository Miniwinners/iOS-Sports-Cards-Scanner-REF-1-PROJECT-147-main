import UIKit
import SnapKit
func vicheslitFibonc321(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiRCV: UIView {

    private var cardsHeightConstraint: Constraint!

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        return collectionView
    }(SportivinieKartiBaseCV(frame: .zero, collectionViewLayout: sozdatLayout()))

    lazy var doneButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(SportivinieKartiCommonB(style: .default))

    lazy var noCardsView: SportivinieKartiCMessageV = { view in
        view.postavitZagolovok(L10n.CardCollection.noCards)
        return view
    }(SportivinieKartiCMessageV())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func postavitImyaKollekcii(_ name: String?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        titleLabel.text = name
//        titleLabel.setLineHeight(UIDevice.isIpad ? 32:28)
    }

    func postavitKarti(count: Int) {
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
    }

    func obnovitKarti(count: Int, animated: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let layout = cardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let cardsWidth = cardsCollectionView.bounds.width
        let horizontalSpacing: CGFloat = (layout?.sectionInset.left ?? 0) + (layout?.sectionInset.right ?? 0)
        let verticalSpacing: CGFloat = (layout?.sectionInset.top ?? 0) + (layout?.sectionInset.bottom ?? 0)
        let itemsInRow: CGFloat = 3
        let interitemSpacing: CGFloat = layout?.minimumInteritemSpacing ?? 0
        let itemWidth = (cardsWidth - horizontalSpacing - (itemsInRow - 1) * interitemSpacing) / itemsInRow
        let photoWidth = itemWidth - 6
        let photoHeight = photoWidth * 1.388
        let itemHeight = photoHeight + 6
        let rowsCount = (CGFloat(count) / itemsInRow).rounded(.up)
        let cardsHeight = itemHeight * rowsCount + interitemSpacing * (rowsCount - 1) + verticalSpacing
        cardsHeightConstraint.update(offset: max(0, cardsHeight))

        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        }
    }

    func vidBezKart(visible: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        noCardsView.isHidden = !visible
    }

}

private extension SportivinieKartiRCV {
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
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.cornerRadius = 12
        backView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        containerView.addSubviews(cardsNumberLabel, cardsCollectionView)

        cardsNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 60: 30)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 80:16)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30:18)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16).priority(.high)
            cardsHeightConstraint = $0.height.equalTo(0).priority(.medium).constraint
        }

        backView.addSubview(noCardsView)
        noCardsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        backView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(containerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
        }
    }

    func sozdatLayout() -> UICollectionViewFlowLayout {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = .init(top: 2, left: 16, bottom: 0, right: 10)
        return layout
    }
}
