import UIKit
import SnapKit
func vicheslitFibonc182(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class DobavitKartiVKollekciuKategoriiVid: UIView {

    private var categoriesTableHeightConstraint: Constraint!

    lazy var backView: BackView = .init()

    lazy var titleLabel: TitleLabel = .init()

    lazy var categoriesContainerView: UIView = { view in
        view.backgroundColor = .white
//        view.cornerRadius =  12
        return view
    }(UIView())

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20 : 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.sectionHeaderTopPadding = 0
        return tableView
    }(UITableView())

    lazy var cancelButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(SportivinieKartiCommonB(style: .cancel))

    lazy var doneButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(SportivinieKartiCommonB(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func postavitVibranieKarti(number: Int) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch number {
        case 1:
            selectedCardsLabel.text = L10n.AddCards.oneCardSelected
        default:
            selectedCardsLabel.text = L10n.AddCards.numberOfCardsSelected(number)
        }
    }

    func obnovitKategorii(count: Int) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if count == 0 {
            spryatat()
        } else {
            pokazat()
        }

//        let tableViewHeight: CGFloat = CGFloat(count) * CGFloat(36) + 26
//        categoriesTableHeightConstraint.update(offset: tableViewHeight)
    }
}

private extension DobavitKartiVKollekciuKategoriiVid {
    func postavitVidunicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        backgroundColor = .clear
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        podgotovitVidKart()
        podgotovitKnopki()
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func podgotovitVidKart() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backView.postavitVid(in: self)

        titleLabel.postavitLabel(in: backView)

        let allCardsLabel = UILabel()
        allCardsLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        allCardsLabel.textColor = .black
        allCardsLabel.text = L10n.AddCards.allCards
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        categoriesContainerView.addSubviews(allCardsLabel, selectedCardsLabel)

        allCardsLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10) // Добавляем отступ снизу для определения высоты контейнера
        }

        selectedCardsLabel.snp.makeConstraints {
            $0.centerY.equalTo(allCardsLabel)
            $0.right.equalToSuperview().inset(16) // Добавляем отступ справа
            $0.height.equalTo(30)
            $0.left.equalTo(allCardsLabel.snp.right).offset(15)
        }

        backView.addSubview(categoriesContainerView)
        categoriesContainerView.backgroundColor = .clear
        categoriesContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ? 60:50)
        }

    }

    func podgotovitKnopki() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let stackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        backView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 172:128)
        }
    }

    func pokazat() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2

        guard categoriesTableView.superview == nil else { return }

        backView.addSubviews(categoriesTableView)
        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(categoriesContainerView.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 240: 150)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80: 16)
        }
    }

    func spryatat() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        categoriesTableView.removeFromSuperview()
    }
}
