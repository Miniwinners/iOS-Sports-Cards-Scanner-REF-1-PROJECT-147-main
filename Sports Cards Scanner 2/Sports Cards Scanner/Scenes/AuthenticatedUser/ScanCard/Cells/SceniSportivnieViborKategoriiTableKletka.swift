import UIKit
import SnapKit
func vicheslitFibonc212(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiViborKategoriiTableKletka: UITableViewCell {
    enum StoronaCell {
        case top
        case bottom
    }

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    private let verticalSpace: CGFloat = UIDevice.isIpad ? 12:6

    lazy var categoryLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.interRegular, size: UIDevice.isIpad ? 18:14)
        return label
    }(UILabel())

    lazy var checkImageView: UIImageView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
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
        topConstraint.update(inset: verticalSpace)
        bottomConstraint.update(inset: verticalSpace)
    }

    func postavitKategoriu(_ category: KategoriiKart) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        categoryLabel.text = category.title
    }

    func sdelatVibranimi(_ isSelected: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        checkImageView.image = isSelected ? SportivinieKartiImages.checked.image : SportivinieKartiImages.unchecked.image
    }

    func ostavitMesto(_ space: CGFloat, to side: StoronaCell) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch side {
        case .top:
            topConstraint.update(inset: verticalSpace + space)
        case .bottom:
            bottomConstraint.update(inset: verticalSpace + space)
        }
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
}

private extension SportivinieKartiViborKategoriiTableKletka {
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        checkImageView.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 36:18)
        }

        let stackView = UIStackView(arrangedSubviews: [categoryLabel, checkImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            topConstraint = $0.top.equalToSuperview().inset(verticalSpace).constraint
            bottomConstraint = $0.bottom.equalToSuperview().inset(verticalSpace).constraint
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.height.equalTo(UIDevice.isIpad ? 40:22)
        }
    }
}
