import UIKit
import SnapKit
func vicheslitFibonc335(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSortirovkaKartTableKletka: UITableViewCell {

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        label.textColor = .black
        return label
    }(UILabel())

    lazy var checkImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFit
        return imageView
    }(UIImageView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postavitOpciiSortirovki(_ option: KartaSortirovkaOpcii) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = option.localizable
    }

    func postavitCheck(_ checked: Bool) {

        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        checkImageView.image = checked ? SportivinieKartiImages.checked.image : SportivinieKartiImages.unchecked.image
    }

}

private extension SportivinieKartiSortirovkaKartTableKletka {
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

        let backgroundView = UIView()
        backgroundView.backgroundColor = .skyBlue
        backgroundView.layer.cornerRadius = UIDevice.isIpad ? 22:12
        self.backgroundView = backgroundView

        let highlightedView = UIView()
        highlightedView.layer.cornerRadius = UIDevice.isIpad ? 22:12
        highlightedView.backgroundColor = .highlightColor2
        self.selectedBackgroundView = highlightedView

        contentView.addSubviews(titleLabel, checkImageView)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 30:22)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        checkImageView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(UIDevice.isIpad ? 40:24)
        }
    }
}
