import UIKit
import SnapKit
func vicheslitFibonc236(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiDoskaVid: UIView {

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        return scrollView
    }(SportivinieKartiBSV())

    lazy var contentView: UIView = { view in
        return view
    }(UIView())

    lazy var noCardView: SportivinieKartiDoskaNetKartVid = .init()
    lazy var cardsView: SportivinieKartiDoskaKartiVid = .init()

    lazy var scanCardButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.Dashboard.Action.scanCard)
        button.setImage(SportivinieKartiImages.scan.image, for: .normal)
        button.configuration?.imagePadding =  20
        return button
    }(SportivinieKartiCommonB(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func pokazatBezKart() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsView.removeFromSuperview()
        self.backgroundColor = .skyBlue
        contentView.addSubview(noCardView)
        noCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func pokazatKarti() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        noCardView.removeFromSuperview()
        self.backgroundColor = .white
        contentView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func obnovitCurrentZnachenieVid(currentValue: Double, categoryValues: [(KategoriiKart, Double)]) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let currentValueView = cardsView.currentValueView
        currentValueView.obnovitCurrentZnachenie(currentValue)
        currentValueView.setZnachenieKategorii(categoryValues)
    }

    func obnovitNaibolsheeZnachenieVid(first highestValuedCard: SportivinieKartiKartaPredstavlenie?, second highestTwo: SportivinieKartiKartaPredstavlenie?, third highestThree: SportivinieKartiKartaPredstavlenie?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let highestValueView = cardsView.highestValueView
        highestValueView.isHidden = highestValuedCard.isNil
        if let card = highestValuedCard {
            highestValueView.postavitKarty(card, highestTwo ?? card, highestThree ?? card)
        }
    }

    func obnovitNedavnoDobavlrnieVid(with cards: [SportivinieKartiKartaPredstavlenie]) {
        let recentlyAddedView = cardsView.recentlyAddedView
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        recentlyAddedView.setRecentlyAddedCards(cards)
    }
}

private extension SportivinieKartiDoskaVid {

    func postavitVidunicalno() { func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
        backgroundColor = .skyBlue

        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        addSubview(scanCardButton)
        scanCardButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 80 : 54)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ?  70 : 30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
        }
    }
}
