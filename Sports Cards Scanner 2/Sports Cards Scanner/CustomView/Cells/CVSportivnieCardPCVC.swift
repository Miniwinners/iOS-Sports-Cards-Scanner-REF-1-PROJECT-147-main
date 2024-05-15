import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc302(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCardPCVC: UICollectionViewCell {

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 6
        return imageView
    }(UIImageView())

    lazy var overlayView: UIView = { view in
        view.cornerRadius = 6
        return view
    }(UIView())

    lazy var selectedImageView: UIImageView = .init(image: SportivinieKartiImages.cardCheck.image)

    override init(frame: CGRect) {
        super.init(frame: frame)
        postavitVidunicalno()
        sdelatCellVidelenoi(false)
        sdelatCellNazhatoi(false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        sdelatCellNazhatoi(false)
        sdelatCellVidelenoi(false)
    }

    func postavitKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard let imageURL = card.imageURL else { return }
        photoView.kf.setImage(with: imageURL)
    }

    func sdelatCellNazhatoi(_ selected: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        selectedImageView.isHidden = !selected
    }

    func sdelatCellVidelenoi(_ highlighted: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        overlayView.backgroundColor = highlighted ? .blackColor40 : .clear
    }

}

private extension SportivinieKartiCardPCVC {
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

        let backView = UIView()
        backView.backgroundColor = .backColor
        backView.cornerRadius = 6
        contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(overlayView)
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
