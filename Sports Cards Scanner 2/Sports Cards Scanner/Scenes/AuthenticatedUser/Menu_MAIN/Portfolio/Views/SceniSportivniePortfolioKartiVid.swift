import UIKit
import SnapKit
import Foundation
func vicheslitFibonc246(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

final class SportivinieKartiPortfolioKartiVid: UIView {
    private var unlock: Bool
    private var previousHeight: CGFloat?

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = UIDevice.isIpad ? 30:20
        return stackView
    }(UIStackView(arrangedSubviews: [infoView, cardContainerView, categoriesCardsView]))

    lazy var cardContainerView: UIView = { view in
        backgroundColor = .clear
        return view
    }(UIView())

    lazy var collectionView: SportivinieKartiKnipkiPerehodaVid = { view in
        view.subtitleCreate.text = L10n.Portfolio.Deck.description
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }(SportivinieKartiKnipkiPerehodaVid(setType: .collection))

    lazy var deckView: SportivinieKartiKnipkiPerehodaVid = { view in
        view.subtitleCreate.text = L10n.Portfolio.Collection.description
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
//        view.lockImageView.isHidden = true
        return view
    }(SportivinieKartiKnipkiPerehodaVid(setType: .deck))

    lazy var collectionButton: SportivinieKartiCommonKnopka = .init(style: .custom(buttonAppearance))
    lazy var deckButton: SportivinieKartiCommonKnopka = .init(style: .custom(buttonAppearance))

    lazy var infoView: SportivinieKartiPortfolioInfoVid = .init()

    lazy var categoriesCardsView: UIView = { view in
        view.backgroundColor = .clear
        view.cornerRadius = UIDevice.isIpad ? 30:12
        return view
    }(UIView())

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }(UITableView())

    private var categoriesCardsHeightConstraint: Constraint!

    init(unlock: Bool) {
        self.unlock = unlock
        print("unlock status - \(unlock)")
        super.init(frame: .zero)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func obnovitKategorii(number: Int) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
//        let inset: CGFloat = UIDevice.isIpad ? 120:74
//        let height = UIDevice.isIpad ? 120:74 * CGFloat(number) + inset
//        categoriesCardsHeightConstraint.update(offset: height)
//        categoriesTableView.reloadData()
    }
}

private extension SportivinieKartiPortfolioKartiVid {
    var buttonAppearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = UIDevice.isIpad ? 20:16
        return .init(
            configuration: configuration,
            backgroundColors: .init(primary: .white, highlighted: .highlightColor2)
        )
    }

    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        setKartiVid()
        setKategoriiKartZnachenie()
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 50:40)
            $0.bottom.equalToSuperview()
        }
    }

    func setKartiVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addSubview(cardContainerView)
        cardContainerView.addSubviews(collectionButton, deckButton)

        collectionButton.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.right.equalTo(deckButton.snp.left).offset(UIDevice.isIpad ? -20 : -10)
            make.width.equalTo(deckButton.snp.width)
        }

        deckButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalTo(collectionButton.snp.right).offset(UIDevice.isIpad ?20:10)
            make.width.equalTo(collectionButton.snp.width)

        }
        collectionButton.addSubview(collectionView)
        deckButton.addSubview(deckView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deckView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }

    func setKategoriiKartZnachenie() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let allCardsLabel = UILabel()
        allCardsLabel.text = L10n.Portfolio.allCards
        allCardsLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?30:24)
        allCardsLabel.textColor = .black
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setVisotaLabla(UIDevice.isIpad ?31:25)

        categoriesCardsView.addSubviews(allCardsLabel, categoriesTableView)
        allCardsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalToSuperview()
        }

        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(allCardsLabel.snp.bottom).offset(15)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 120 * 8 - 8 * 7 : 74 * 8 - 8 * 7 + 60)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 70 : 30)
        }
    }
}

extension SportivinieKartiPortfolioKartiVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func podgotovitContainer() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardContainerView.snp.updateConstraints { make in
            let maxButtonHeight = max(collectionButton.frame.height, deckButton.frame.height)
//            print("collectionButton - \(collectionButton.frame.height)")
//            print("deckButton - \(deckButton.frame.height)")
//            print("Current max height container: \(maxButtonHeight), Previous height: \(previousHeight)")

            if maxButtonHeight != previousHeight {
                previousHeight = maxButtonHeight
                make.height.equalTo(previousHeight ?? 0)
            }
        }
    }
}
