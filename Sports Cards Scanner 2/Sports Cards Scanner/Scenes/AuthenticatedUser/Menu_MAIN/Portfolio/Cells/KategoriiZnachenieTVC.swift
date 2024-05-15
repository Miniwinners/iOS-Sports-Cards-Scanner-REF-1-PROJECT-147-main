import UIKit
import SnapKit
func vicheslitFibonc241(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class KategoriiZnachenieTVC: UITableViewCell {

    lazy var categoryLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 20: 14)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var valueLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ?26:20)
        label.textColor = .greenColor
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ?20:14)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var cardImageView: UIImageView = { imageView in
        return imageView
    }(UIImageView())

    private var selfHeightConstraint: Constraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postavitKategoriu(_ category: KategoriiKart) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        categoryLabel.text = category.shortTitle
        categoryLabel.setVisotaLabla(UIDevice.isIpad ?28:22)
    }

    func postavirZnachenieKarti(_ value: Double) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        valueLabel.text = value.formattedAsPrice
        valueLabel.setVisotaLabla(UIDevice.isIpad ?28:22)
    }

    func postavitPhotoKarti(_ image: UIImage) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardImageView.image = image
    }

    func postavitNomerKarti(_ number: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch number {
        case 0:
            cardsNumberLabel.text = L10n.Portfolio.scanToAdd
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard.uppercased()
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(number).uppercased()
        }
        cardsNumberLabel.setVisotaLabla(UIDevice.isIpad ?23:17)
        cardsNumberLabel.textAlignment = .right
    }

    lazy var containerView: UIView = .init()

}

extension KategoriiZnachenieTVC {
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
        backgroundColor = .white
        layer.cornerRadius = UIDevice.isIpad ? 26:16
        layer.masksToBounds = true
        let highlightedView = UIView()
        highlightedView.layer.cornerRadius = UIDevice.isIpad ? 26:16
        highlightedView.backgroundColor = .highlightColor2
        selectedBackgroundView = highlightedView

        containerView.layer.cornerRadius = UIDevice.isIpad ? 26:16
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview()
//            selfHeightConstraint = $0.height.equalTo(0).offset(UIDevice.isIpad ?200:100).constraint
            $0.height.equalTo(UIDevice.isIpad ? 120: 78)
        }

        containerView.addSubviews(cardImageView, categoryLabel, valueLabel, cardsNumberLabel)
        cardImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
            make.size.equalTo(UIDevice.isIpad ? 36:22)
        }
        categoryLabel.snp.makeConstraints {
//            $0.top.equalToSuperview().inset(10)
            $0.leading.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
        }

        valueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
            $0.right.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(categoryLabel)
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(10)
            $0.right.equalToSuperview().inset(UIDevice.isIpad ? 20:15)
        }

    }
}
