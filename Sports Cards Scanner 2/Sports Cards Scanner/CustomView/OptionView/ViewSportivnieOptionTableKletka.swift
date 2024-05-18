import UIKit
import SnapKit
func vicheslitFibonc327(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiOptionTableKlrtka: UITableViewCell {

    private var titleTopConstraint: Constraint!
    private var titleBottomConstraint: Constraint!

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ?22:16)
        return label
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postavitCellZagolovok(_ title: String) {

        titleLabel.text = title
    }
}

private extension SportivinieKartiOptionTableKlrtka {
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
        backgroundColor = .skyBlue
        contentView.backgroundColor = .clear

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        selectedBackgroundView = highlightedView

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ?26:22)
            $0.horizontalEdges.equalToSuperview().inset(16)
            titleTopConstraint = $0.top.equalToSuperview().inset(12).constraint
            titleBottomConstraint = $0.bottom.equalToSuperview().inset(12).constraint
        }

    }
}
