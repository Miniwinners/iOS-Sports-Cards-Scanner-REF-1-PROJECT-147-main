import UIKit
import SnapKit
func vicheslitFibonc305(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiPricingRB {
    final class SportivinieKartiPRBCPV: UIView {

        var type: ButtonTypeReport! {
            didSet {
                podgotovitVid()
            }
        }

        lazy var editLabel: UILabel = .init()
        lazy var priceLabel: UILabel = .init()
        lazy var editImageView: UIImageView = .init(image: SportivinieKartiImages.MenuKollekcii.renameCollection.image)

        convenience init(type: ButtonTypeReport) {
            self.init(frame: .zero)
            self.type = type
            postavitVidunicalno()
        }

        override func layoutSubviews() {
            func generirovantRandomniiIPaDRESS() -> String {
                let octet1 = Int.random(in: 0...255)
                let octet2 = Int.random(in: 0...255)
                let octet3 = Int.random(in: 0...255)
                let octet4 = Int.random(in: 0...255)
                return "\(octet1).\(octet2).\(octet3).\(octet4)"
            }
            super.layoutSubviews()
            if type == .add {
                self.sdelatGranici()
            }
        }

    }

}

extension SportivinieKartiPricingRB.SportivinieKartiPRBCPV {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitCeny(_ price: String?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        editLabel.text = price.isNil ? L10n.PricingReport.setCustomPrice : L10n.PricingReport.editCustomPrice
        priceLabel.text = price ?? "-"
    }

    private func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        layer.cornerRadius = 12
        podgotovitVid()
    }

    private func podgotovitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        editLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        editLabel.textColor = .black
        editLabel.textAlignment = UIDevice.isIpad ? .center:.left
        addSubview(editLabel)

        addSubview(editImageView)

        priceLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 20:14)
        priceLabel.textColor = .greenColor
        priceLabel.textAlignment = UIDevice.isIpad ? .center:.left

        addSubview(priceLabel)

        switch type {
        case .add:
            editImageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(20)
                make.size.equalTo(UIDevice.isIpad ? 42:32)
                make.centerX.equalToSuperview()
            }
            editLabel.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(UIDevice.isIpad ? 45:30)
                make.height.equalTo(UIDevice.isIpad ? 30:20)
                make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
            priceLabel.snp.remakeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.height.equalTo(UIDevice.isIpad ? 24:18)

            }
        case .main:
            editLabel.snp.remakeConstraints {
                $0.top.equalToSuperview().inset(UIDevice.isIpad ? 18:12)
                $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 22:16)
            }

            editImageView.snp.remakeConstraints {
                $0.size.equalTo(UIDevice.isIpad ? 42:32)
                $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 24:16)
                $0.centerY.equalToSuperview()
            }
            priceLabel.snp.remakeConstraints {
                $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 24:16)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.height.equalTo(UIDevice.isIpad ? 24:18)
            }
        default: break
        }
    }

}
