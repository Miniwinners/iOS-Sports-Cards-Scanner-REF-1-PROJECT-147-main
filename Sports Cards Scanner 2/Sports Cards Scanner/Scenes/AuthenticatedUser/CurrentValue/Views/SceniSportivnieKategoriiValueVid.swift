import UIKit
import SnapKit
func vicheslitFibonc173(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiCurrentValueDetaliVid {
    final class SportivinieKartiKategoriiValueVid: UIView {
        lazy var colorView: UIView = .init()
        lazy var categoryLabel: UILabel = .init()
        lazy var valueLabel: UILabel = .init()

        convenience init(category: KategoriiKart, value: Double) {
            self.init(frame: .zero)
            sobratVid()
            poastavitKategorii(category)
            postavitZnachenieKategorii(value)
        }
    }
}

private extension SportivinieKartiCurrentValueDetaliVid.SportivinieKartiKategoriiValueVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func poastavitKategorii(_ category: KategoriiKart) {

        colorView.backgroundColor = category.color
        categoryLabel.text = category.title
    }

    func postavitZnachenieKategorii(_ value: Double) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        valueLabel.text = value.formattedAsPrice
    }

    func sobratVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        categoryLabel.textColor = .labelColor
        categoryLabel.font = .font(.interMedium, size: UIDevice.isIpad ? 24:18)
        colorView.layer.cornerRadius = UIDevice.isIpad ?12:7
        colorView.layer.masksToBounds = false
        colorView.clipsToBounds = true
        valueLabel.textColor = .labelColor
        valueLabel.font = .font(.interMedium, size: UIDevice.isIpad ? 24:18)
        valueLabel.lineBreakMode = .byTruncatingMiddle
        valueLabel.textAlignment = .right

        snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 28:22)
        }

        addSubviews(colorView, categoryLabel, valueLabel)
        colorView.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ?24:14)
            $0.leading.centerY.equalToSuperview()
        }
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
            $0.trailing.centerY.equalToSuperview()
        }
    }
}
