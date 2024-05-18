import UIKit
import SnapKit
func vicheslitFibonc162(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPoiskKartiVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()
    lazy var searchTextField: SportivinieKartiCustomTextPole = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: UIDevice.isIpad ? 24: 16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 30:12
        textField.placeholder = L10n.SearchCard.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.tintColor = .black
        return textField
    }(SportivinieKartiCustomTextPole())

    var searchImageView: UIImageView?

    lazy var loadingIndicatorView: UIActivityIndicatorView = { indicator in
        indicator.tintColor = .labelColor
        indicator.hidesWhenStopped = true
        return indicator
    }(UIActivityIndicatorView(style: .medium))

    lazy var noResultsView: SportivinieKartiCustomMessageVid = { view in
        view.postavitZagolovok(L10n.SearchCard.Error.tryAgain)
        return view
    }(SportivinieKartiCustomMessageVid())

    lazy var searchCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }(UICollectionView(frame: .zero, collectionViewLayout: filterLayout()))

    convenience init() {
        self.init(frame: .zero)
        computeViewsSportivinieKarti()
    }

    func setNoResultsView(visible: Bool) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        searchCollectionView.isUserInteractionEnabled = !visible
        noResultsView.isHidden = !visible
    }

    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func postavitZagryzky(_ isLoading: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        searchImageView?.isHidden = isLoading
        if isLoading {
            loadingIndicatorView.startAnimating()
        } else {
            loadingIndicatorView.stopAnimating()
        }
    }

}

private extension SportivinieKartiPoiskKartiVid {
    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }
    func computeViewsSportivinieKarti() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        backView.postavitVid(in: self)
        titleLabel.postavitLabel(in: backView)

        backView.addSubviews(searchTextField, searchCollectionView, noResultsView)
        podgotovitTextPole()
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 100 : 48)
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40 : 30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        noResultsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        setNoResultsView(visible: false)

        searchCollectionView.isUserInteractionEnabled = false
    }

    func podgotovitTextPole() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let imageView = searchTextField.postavirPhotoUnicalno(
            SportivinieKartiImages.search.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )
        searchTextField.rightView?.addSubview(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }

        searchImageView = imageView
    }
}

private extension SportivinieKartiPoiskKartiVid {
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
