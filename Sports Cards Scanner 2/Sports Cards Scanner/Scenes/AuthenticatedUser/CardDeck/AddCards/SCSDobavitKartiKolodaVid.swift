import UIKit
import SnapKit
func vicheslitFibonc254(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiDobavitKartiKolodaVid: UIView {

    lazy var backView: BackView = .init()

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 28:22)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var searchTextField: SportivinieKartiCTExtF = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: UIDevice.isIpad ? 22:16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 20:12
        textField.placeholder = L10n.AddCards.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }(SportivinieKartiCTExtF())

    var searchImageView: UIImageView!

    lazy var clearSearchButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.clear.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var categoryLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        label.textColor = .black
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsCollectionView: UICollectionView = { tableView in
        tableView.alwaysBounceVertical = false
        tableView.allowsMultipleSelection = true
        tableView.backgroundColor = .clear
        return tableView
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    lazy var noResultsView: SportivinieKartiCMessageV = { view in
        view.postavitZagolovok(L10n.AddCards.noResult)
        return view
    }(SportivinieKartiCMessageV())

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

    func postavitKategoriu(_ category: KategoriiKart?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        categoryLabel.text = category?.title
        categoryLabel.setVisotaLabla(UIDevice.isIpad ? 28:22)
    }

    func postavitVibranieKarti(number: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch number {
        case 1:
            selectedCardsLabel.text = L10n.AddCards.oneCardSelected
        default:
            selectedCardsLabel.text = L10n.AddCards.numberOfCardsSelected(number)
        }
        selectedCardsLabel.setVisotaLabla(UIDevice.isIpad ? 28:22)
    }

    func postavitVidBezResultatov(visible: Bool) {
        noResultsView.isHidden = !visible
    }

}

private extension SportivinieKartiDobavitKartiKolodaVid {
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        backView.postavitVid(in: self)
        podgotovitTextPole()

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20

        backView.addSubviews(selectedCardsLabel, searchTextField, categoryLabel, cardsCollectionView, buttonsStackView, noResultsView)
        selectedCardsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 52:32)
            $0.centerX.equalToSuperview()
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(selectedCardsLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ? 100:48)
        }
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:0)
        }
        noResultsView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        buttonsStackView.snp.makeConstraints {
            $0.top.equalTo(cardsCollectionView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 40:20)
            $0.height.equalTo(UIDevice.isIpad ? 172:128)
        }

        postavitVidBezResultatov(visible: false)
    }

    func podgotovitTextPole() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        searchImageView = searchTextField.postavirPhotoUnicalno(
            SportivinieKartiImages.search.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )
        searchTextField.rightView?.addSubview(clearSearchButton)
        clearSearchButton.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.center.equalTo(searchImageView)
        }
        clearSearchButton.isHidden = true
    }
}

private extension SportivinieKartiDobavitKartiKolodaVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
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
