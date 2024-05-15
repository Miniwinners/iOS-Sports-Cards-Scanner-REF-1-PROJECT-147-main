import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc313(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCardMV: UIView {

    static let viewHeight: CGFloat = UIDevice.isIpad ? 440 : 297

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.postavitRazmer(fontS: .ubuntuMedium500, phone: 16, iPad: 22)
        label.numberOfLines = 2
        label.setVisotaLabla(UIDevice.isIpad ? 24:18)
        return label
    }(UILabel())

    lazy var subtitleLabel: UILabel = { label in
        label.textColor = .singINLabel
        label.postavitRazmer(fontS: .ubuntuMedium500, phone: 12, iPad: 18)
        label.numberOfLines = 2
        return label
    }(UILabel())

    lazy var cardImageView: UIImageView = { imageView in
        imageView.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var missingImageLabel: UILabel = { label in
        label.text = L10n.Card.missingImage
        label.setVisotaLabla(19)
        label.textColor = .labelColor3
        label.font = .font(.ubuntuRegular400, size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var missingImageView: UIView = { view in
        view.cornerRadius = 12
        view.backgroundColor = .black
        return view
    }(UIView())

    lazy var checkedView: UIView = { view in
        view.backgroundColor = .blackColor40
        view.cornerRadius = 12
        view.isHidden = true
        return view
    }(UIView())

    lazy var numberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 14)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var numberView: UIView = { view in
        view.cornerRadius = 16
        view.backgroundColor = .cardBackColor
        return view
    }(UIView())

    lazy var pricesLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        label.textColor = .greenColor
        return label
    }(UILabel())

    private var pricesLeadingConstraint: Constraint?
    private var pricesTrailingConstraint: Constraint?
    private var numberPricesSpaceConstraint: Constraint?

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
        postavitKarteChislo(nil)
    }

    func resetVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        missingImageLabel.isHidden = false
        cardImageView.kf.cancelDownloadTask()
        cardImageView.kf.setImage(with: URL(string: ""))
        cardImageView.image = nil
    }

    func postavitKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = card.title
        subtitleLabel.text = card.subtitle
        if let price = card.customPrice {
            pricesLabel.text = price.formattedAsPrice
        } else {
            pricesLabel.text = card.diapazonCen(of: card.selectedGrader)
        }
        pricesLabel.lineBreakMode = .byTruncatingMiddle
        pricesLabel.textAlignment = .left

        if let imageURL = card.imageURL {
            missingImageLabel.isHidden = true
            cardImageView.kf.setImage(with: imageURL)
        }
    }

    func sdelatProverenim(_ checked: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        checkedView.isHidden = !checked
    }

    func postavitKarteChislo(_ number: Int?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        numberView.isHidden = number.isNil
        if let number = number {
            numberLabel.text = "#\(number)"
            pricesLeadingConstraint?.deactivate()
            pricesTrailingConstraint?.activate()
            numberPricesSpaceConstraint?.activate()
        } else {
            pricesLeadingConstraint?.activate()
            pricesTrailingConstraint?.deactivate()
            numberPricesSpaceConstraint?.deactivate()
        }
    }

}

private extension SportivinieKartiCardMV {
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

        let checkedImageView = UIImageView(image: SportivinieKartiImages.cardCheck.image)
        checkedView.addSubview(checkedImageView)
        checkedImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        addSubviews(cardImageView, titleLabel, subtitleLabel, pricesLabel, missingImageView, checkedView, numberView)

        self.snp.makeConstraints {
            $0.height.equalTo(Self.viewHeight)
        }
        cardImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 304:195)
            $0.width.equalTo(UIDevice.isIpad ? 215:138)
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(UIDevice.isIpad ? 70:60)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(cardImageView.snp.bottom).offset(UIDevice.isIpad ? 15:10)
        }
        subtitleLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5)
            $0.left.right.equalToSuperview()
        }
        pricesLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5)
            $0.leading.equalToSuperview()
        }

        missingImageView.snp.makeConstraints {
            $0.edges.equalTo(cardImageView)
        }
        checkedView.snp.makeConstraints {
            $0.edges.equalTo(cardImageView)
        }

        missingImageView.addSubview(missingImageLabel)
        missingImageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        numberView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
