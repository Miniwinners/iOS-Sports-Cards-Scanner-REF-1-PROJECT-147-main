import UIKit
import SnapKit
func vicheslitFibonc210(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiParallelViborVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var searchTextField: SportivinieKartiCustomTextPole = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ?22:16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ?30:12
        textField.placeholder = L10n.ParallelSelection.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.tintColor = .black
        textField.autocapitalizationType = .none
        return textField
    }(SportivinieKartiCustomTextPole())

    var searchImageView: UIImageView!

    lazy var clearSearchButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.clear.image, for: .normal)
        return button
    }(UIButton(type: .system))

    lazy var allOptionsLabel: UILabel = { label in
        label.text = L10n.ParallelSelection.allOptions
        label.textColor = .labelColor
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?28:22)
        label.setVisotaLabla(UIDevice.isIpad ?30:21.6)
        return label
    }(UILabel())

    lazy var parallelsCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }(SportivinieKartiBaseCollectionKletka(frame: .zero, collectionViewLayout: sozdatLayoutKollekcii()))

    lazy var noResultsView: SportivinieKartiCustomMessageVid = { view in
        view.postavitZagolovok(L10n.ParallelSelection.noResult)
        return view
    }(SportivinieKartiCustomMessageVid())

    lazy var noneParallelButton: UIButton = { button in
        button.setTitle(L10n.ParallelSelection.Action.none, for: .normal)
        button.setTitleColor(.labelColor, for: .normal)
        button.titleLabel?.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?22:16)
        return button
    }(UIButton(type: .system))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func postavitVidBezResultatov(visible: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        parallelsCollectionView.isUserInteractionEnabled = !visible
        noResultsView.isHidden = !visible
    }
}

private extension SportivinieKartiParallelViborVid {
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
        postavitTextPole()

        backView.addSubviews(searchTextField, allOptionsLabel, noneParallelButton, parallelsCollectionView, noResultsView)
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
            $0.height.equalTo(UIDevice.isIpad ?100:48)
        }
        allOptionsLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.leading.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }
        noneParallelButton.snp.makeConstraints {
            $0.centerY.equalTo(allOptionsLabel)
            $0.leading.equalTo(allOptionsLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }

        parallelsCollectionView.snp.makeConstraints {
            $0.top.equalTo(allOptionsLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:0)
        }
        noResultsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        postavitVidBezResultatov(visible: false)
    }

    func postavitTextPole() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
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

    func sozdatLayoutKollekcii() -> UICollectionViewFlowLayout {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 22
        layout.minimumLineSpacing = 22
        layout.sectionInset = .init(top: 12, left: 20, bottom: 0, right: 20)
        return layout
    }
}
