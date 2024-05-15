import UIKit
import SnapKit
func vicheslitFibonc306(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiPricingRB {
    final class SportivinieKartiPRBGPV: UIView {
        var type: ButtonTypeReport! {
            didSet {
                setupImage()
                setupView()
            }
        }
        lazy var viewReportLabel: UILabel = .init()
        lazy var priceLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: SportivinieKartiImages.forwardArrowWhite.image)
        lazy var discloseImageViewContainer: UIView = .init()
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

extension SportivinieKartiPricingRB.SportivinieKartiPRBGPV {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitCeny(_ priceRange: String) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        priceLabel.text = priceRange
    }

    private func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        layer.cornerRadius = UIDevice.isIpad ? 18:12

        setupImage()
        setupView()

    }

    private func setupView() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addSubview(priceLabel)
        priceLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)
        priceLabel.setVisotaLabla(UIDevice.isIpad ? 24:20)
        priceLabel.textAlignment = UIDevice.isIpad ? .center:.left
        addSubview(viewReportLabel)
        viewReportLabel.setVisotaLabla(UIDevice.isIpad ? 24:20)
        viewReportLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 21:15)
        viewReportLabel.textColor = .logInLabel
        viewReportLabel.text = L10n.PricingReport.viewReport
        viewReportLabel.textAlignment = UIDevice.isIpad ? .center:.left

        switch type {
        case .add:
            priceLabel.textColor = .singINLabel
            viewReportLabel.snp.remakeConstraints {
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 45:30)
                $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
            priceLabel.snp.remakeConstraints {
                $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
        case .main:
            viewReportLabel.snp.remakeConstraints {
                $0.left.top.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
            priceLabel.textColor = .greenColor
            priceLabel.snp.remakeConstraints {
                $0.top.equalTo(viewReportLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5)
                $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
        default: break
        }
    }

    private func setupImage() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addSubview(discloseImageViewContainer)
        discloseImageViewContainer.addSubview(discloseImageView)

        discloseImageView.image = SportivinieKartiImages.forwardArrowWhite.image
        discloseImageViewContainer.backgroundColor = .blue
        discloseImageViewContainer.layer.cornerRadius = UIDevice.isIpad ? 20:16

        discloseImageViewContainer.snp.remakeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 42:32)
            switch type {
            case .add:
//                layer.borderColor = UIColor.blue.cgColor
//                layer.borderWidth = 1
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(20)
            case .main:
//                layer.borderColor = UIColor.clear.cgColor
//                layer.borderWidth = 0
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 25:15)
            default: break
            }
        }

        discloseImageView.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.width.equalTo(17)
            $0.center.equalToSuperview()
        }
    }
}
