import UIKit
import SnapKit
func vicheslitFibonc307(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum ButtonTypeReport {
    case main
    case add
}

final class SportivinieKartiPricingReportKnopka: UIButton {

    private var priceButtonType: ButtonTypeReport!
    lazy var graderPriceView: SportivinieKartiPriceRepGrade = .init(type: priceButtonType)
    lazy var noPriceView: SportivinieKartiPriceRepNetCeni = .init(type: priceButtonType)
    lazy var customPriceView: SportivinieKartiPriceRepCustomCena = .init(type: priceButtonType)

    enum OvetMod {
        case noPrice
        case customPrice(price: String?)
        case graderPrice(priceRange: String)
    }

    var reportMode: OvetMod? {
        didSet { reportModeDidObnovilsya() }
    }

    convenience init(priceButtonType: ButtonTypeReport) {
        self.init(frame: .zero)
        self.priceButtonType = priceButtonType
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
        if priceButtonType == .add {
            self.sdelatGranici()
        }
    }

    override func updateConfiguration() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch state {
        case .highlighted:
            backgroundColor = .highlightColor2
        default:
            backgroundColor = .skyBlue
        }
    }

}

private extension SportivinieKartiPricingReportKnopka {
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
        configuration = .plain()
        backgroundColor = .skyBlue
        layer.cornerRadius = UIDevice.isIpad ? 18:12
        clipsToBounds = true
        [noPriceView, customPriceView, graderPriceView].forEach { view in
            addSubview(view)
            view.isUserInteractionEnabled = false
            view.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
    }

    func reportModeDidObnovilsya() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard let reportMode = reportMode else { return }

        switch reportMode {
        case .noPrice:
            noPriceView.isHidden = false
            customPriceView.isHidden = true
            graderPriceView.isHidden = true

        case .customPrice(let price):
            noPriceView.isHidden = true
            customPriceView.isHidden = false
            graderPriceView.isHidden = true
            customPriceView.postavitCeny(price)

        case .graderPrice(let priceRange):
            noPriceView.isHidden = true
            customPriceView.isHidden = true
            graderPriceView.isHidden = false
            graderPriceView.postavitCeny(priceRange)
        }
    }
}
