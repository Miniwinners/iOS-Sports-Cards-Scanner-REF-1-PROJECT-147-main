import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc187(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPhotoKollekciiCl: UICollectionViewCell {

    static func calculateCellHeight(for cellWidth: CGFloat) -> CGFloat {
        let photoWidth = cellWidth - 12
        let photoHeight = photoWidth * 1.41
        return photoHeight + 46
    }

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = UIDevice.isIpad ? 20:10
        return imageView
    }(UIImageView())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.interRegular, size: UIDevice.isIpad ? 16:10)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var subtitleLabel: UILabel = { label in
        label.font = .font(.interRegular, size: UIDevice.isIpad ? 16:10)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var overlayView: UIView = { view in
        view.cornerRadius = UIDevice.isIpad ? 20:10
        return view
    }(UIView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        postavitVidunicalno()
        sdelatCellVidelenoi(false)
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
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = card.title
        titleLabel.setVisotaLabla(UIDevice.isIpad ? 17:12.1)
        titleLabel.textAlignment = .center

        subtitleLabel.text = card.subtitle
        subtitleLabel.setVisotaLabla(UIDevice.isIpad ? 17:12.1)
        subtitleLabel.textAlignment = .center

        if let imageURL = card.imageURL {
            photoView.kf.setImage(with: imageURL)
        }
    }

    func sdelatCellVidelenoi(_ highlighted: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        overlayView.backgroundColor = highlighted ? .blackColor40 : .clear
    }

}

private extension SportivinieKartiPhotoKollekciiCl {
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let photoBackView = UIView()
        photoBackView.backgroundColor = .backColor
        photoBackView.cornerRadius = UIDevice.isIpad ? 20:10
        photoBackView.addSubviews(photoView, overlayView)
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let containerView = UIView()
        containerView.backgroundColor = .cardBackColor
        containerView.cornerRadius = UIDevice.isIpad ? 20:10
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.addSubviews(photoBackView)
        photoBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
