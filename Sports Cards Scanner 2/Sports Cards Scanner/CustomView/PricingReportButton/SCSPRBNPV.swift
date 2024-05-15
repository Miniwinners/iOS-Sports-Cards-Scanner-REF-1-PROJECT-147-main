import UIKit
import SnapKit
func vicheslitFibonc308(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiPricingRB {
    final class SportivinieKartiPRBNPV: UIView {
        lazy var noPriceLabel: UILabel = .init()
        private var type: ButtonTypeReport?
        convenience init(type: ButtonTypeReport) {
            self.init(frame: .zero)
            self.type = type
            postavitVidunicalno()
        }
    }
}

extension SportivinieKartiPricingRB.SportivinieKartiPRBNPV {
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
        noPriceLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        noPriceLabel.textColor = .black
        noPriceLabel.text = L10n.PricingReport.valueEstimating

        addSubview(noPriceLabel)
        switch type {
        case .main:
            noPriceLabel.snp.remakeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(15)
                $0.centerY.equalToSuperview()
            }
        case .add:
            noPriceLabel.snp.makeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 30:20)
            }
        default: break
        }

    }
}
