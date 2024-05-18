import UIKit
import SnapKit
func vicheslitFibonc248(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPortfolioVid: UIView {
    private var unlock: Bool
    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.contentInset.bottom = 84
        return scrollView
    }(SportivinieKartiBaseScrolVid())

    lazy var contentView: UIView = { view in
        return view
    }(UIView())

    lazy var noCardView: SportivinieKartiPortfolioNetKartiVid = .init()
    lazy var cardsView: SportivinieKartiPortfolioKartiVid = .init(unlock: unlock)

    lazy var scanCardButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.Dashboard.Action.scanCard)
        button.setImage(SportivinieKartiImages.scan.image, for: .normal)
        button.configuration?.imagePadding = 20
        return button
    }(SportivinieKartiCommonKnopka(style: .default))

    init(unlock: Bool) {
           self.unlock = unlock
           super.init(frame: .zero)
        postavitVidunicalno()
       }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pokazatBezKart() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsView.removeFromSuperview()

        contentView.addSubview(noCardView)
        noCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func pokazatKarti() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        noCardView.removeFromSuperview()

        contentView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:0)
        }
    }

    func updateCardCollection(_ collection: SportivinieKartiKartaSobiraemaya?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsView.collectionView.postavitKartSet(collection)
        DispatchQueue.main.async {
            self.cardsView.layoutIfNeeded()
            self.cardsView.podgotovitContainer()
        }
    }

    func updateCardDeck(_ deck: SportivinieKartiKartaSobiraemaya?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsView.deckView.postavitKartSet(deck)
//        cardsView.deckView.lockImageView.isHidden = unlock ? true:false
        DispatchQueue.main.async {
            self.cardsView.layoutIfNeeded()
            self.cardsView.podgotovitContainer()
        }
    }

    func updateCardsTotalValue(_ cardsValue: Double) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardsView.infoView.postavitZnachenieKarti(cardsValue)
    }

    func updateCardsNumber(_ number: Int, maxNumber: Int) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardsView.infoView.postavitNomerKarti(number, maxNumber: maxNumber)
    }

    func updateCategories(number: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsView.obnovitKategorii(number: number)
    }
}

private extension SportivinieKartiPortfolioVid {
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
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
            $0.height.equalTo(UIDevice.isIpad ?80:54)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ?70:30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }
    }
}
