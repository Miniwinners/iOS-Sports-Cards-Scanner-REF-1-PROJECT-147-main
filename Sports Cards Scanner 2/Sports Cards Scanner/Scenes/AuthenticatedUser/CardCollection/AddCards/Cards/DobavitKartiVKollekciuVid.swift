import UIKit
import SnapKit
func vicheslitFibonc179(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class DobavitKartiVKollekciuVid: UIView {

    private var cardsHeightConstraint: Constraint!

    lazy var backView: BackView = .init()

    lazy var titleLabel: TitleLabel = .init()

    lazy var searchTextField: SportivinieKartiCustomTextPole = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 30:12
        textField.placeholder = L10n.AddCards.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.tintColor = .black
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }(SportivinieKartiCustomTextPole())

    var searchImageView: UIImageView!

    lazy var clearSearchButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.clear.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        label.textColor = .black
        return label
    }(UILabel())

    lazy var selectAllButton: UIButton = { button in
        let attributedTitle = NSAttributedString(
            string: L10n.AddCards.Action.selectAll,
            attributes: [.font: UIFont.font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var cardsContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = UIDevice.isIpad ? 22:12
        return view
    }(UIView())

    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .skyBlue
        return collectionView
    }(SportivinieKartiBaseCollectionKletka(frame: .zero, collectionViewLayout: sozdatLayout()))

    lazy var noResultsView: SportivinieKartiCustomMessageVid = { view in
        view.postavitZagolovok(L10n.AddCards.noResult)
        return view
    }(SportivinieKartiCustomMessageVid())

    lazy var cancelButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(SportivinieKartiCommonKnopka(style: .cancel))

    lazy var doneButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(SportivinieKartiCommonKnopka(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func setVibranieKarti(number: Int) {
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
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitKarti(count: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let layout = cardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let cardsWidth = cardsCollectionView.bounds.width
        let horizontalSpacing: CGFloat = (layout?.sectionInset.left ?? 0) + (layout?.sectionInset.right ?? 0)
        let itemsInRow: CGFloat = 3
        let interitemSpacing: CGFloat = layout?.minimumInteritemSpacing ?? 0
        let itemWidth = (cardsWidth - horizontalSpacing - (itemsInRow - 1) * interitemSpacing) / itemsInRow
        let itemHeight = itemWidth * 1.388
        let rowsCount = (CGFloat(count) / itemsInRow).rounded(.up)
        let cardsHeight = itemHeight * rowsCount + interitemSpacing * (rowsCount - 1)
        cardsHeightConstraint.update(offset: max(0, cardsHeight))

    }

    func postavitBezRezyltatovVid(visible: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        noResultsView.isHidden = !visible
    }

}

private extension DobavitKartiVKollekciuVid {
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        backView.postavitVid(in: self)
        titleLabel.postavitLabel(in: backView)

        podgotovitTextPole()

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20

        backView.addSubviews(searchTextField, selectedCardsLabel, selectAllButton, cardsContainerView, noResultsView, buttonsStackView)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 50:30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
            $0.height.equalTo(UIDevice.isIpad ? 100:56)
        }
        selectedCardsLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ?32:22)
        }
        selectAllButton.snp.makeConstraints {
            $0.centerY.equalTo(selectedCardsLabel)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }
        sdelatContainerDlyaKart()

        cardsContainerView.snp.makeConstraints {
            $0.top.equalTo(selectedCardsLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        noResultsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        buttonsStackView.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 172:112)
            $0.top.greaterThanOrEqualTo(cardsContainerView.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
        }

        postavitBezRezyltatovVid(visible: false)
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

    func sdelatContainerDlyaKart() {
        cardsContainerView.addSubview(cardsCollectionView)
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(selectAllButton.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.high)
            cardsHeightConstraint = $0.height.equalTo(0).priority(.medium).constraint
        }
    }

    func sozdatLayout() -> UICollectionViewFlowLayout {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = .init(top: 16, left: 16, bottom: 16, right: 16)
        return layout
    }
}
