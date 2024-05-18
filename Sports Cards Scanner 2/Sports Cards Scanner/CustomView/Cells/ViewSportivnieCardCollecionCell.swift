import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc297(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiRCardCollectionKletka: UICollectionViewCell {

    var removeCardDidTap: ((SportivinieKartiKartaPredstavlenie) -> Void)?

    private var card: SportivinieKartiKartaPredstavlenie?

    // MARK: - Subviews

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 6
        return imageView
    }(UIImageView())

    lazy var removeButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.remove.image, for: .normal)
        return button
    }(UIButton(type: .system))

    override init(frame: CGRect) {
        super.init(frame: frame)
        postavitVidunicalno()
        postavidDeistviaUnicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        photoView.kf.cancelDownloadTask()
        photoView.kf.setImage(with: URL(string: ""))
        photoView.image = nil
        card = nil
    }

    func postavitKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        self.card = card
        if let imageURL = card.imageURL {
            photoView.kf.setImage(with: imageURL)
        }
    }
}

private extension SportivinieKartiRCardCollectionKletka {
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
        contentView.backgroundColor = .clear

        contentView.addSubviews(photoView, removeButton)
        photoView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(6)
            $0.leading.bottom.equalToSuperview()
        }
        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(-13)
            $0.size.equalTo(UIDevice.isIpad ? 80:44)
        }
    }

    func postavidDeistviaUnicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        removeButton.addTarget(self, action: #selector(ybratNazhata), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func ybratNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let card = card else { return }
        removeCardDidTap?(card)
    }
}
