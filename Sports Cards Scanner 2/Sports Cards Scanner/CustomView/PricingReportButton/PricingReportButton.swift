import UIKit
import SnapKit

enum ButtonTypeReport {
    case main
    case add
}

final class PricingReportButton: UIButton {

    private var priceButtonType: ButtonTypeReport!
    lazy var graderPriceView: GraderPriceView = .init(type: priceButtonType)
    lazy var noPriceView: NoPriceView = .init(type: priceButtonType)
    lazy var customPriceView: CustomPriceView = .init(type: priceButtonType)

    enum ReportMode {
        case noPrice
        case customPrice(price: String?)
        case graderPrice(priceRange: String)
    }

    var reportMode: ReportMode? {
        didSet { reportModeDidUpdate() }
    }

    convenience init(priceButtonType: ButtonTypeReport) {
        self.init(frame: .zero)
        self.priceButtonType = priceButtonType
        setupSubviews_unique()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if priceButtonType == .add {
            self.makeBorder()
        }
    }

    override func updateConfiguration() {
        switch state {
        case .highlighted:
            backgroundColor = .highlightColor2
        default:
            backgroundColor = .skyBlue
        }
    }

}

private extension PricingReportButton {
    func setupSubviews_unique() {
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

    func reportModeDidUpdate() {
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
            customPriceView.setPrice(price)

        case .graderPrice(let priceRange):
            noPriceView.isHidden = true
            customPriceView.isHidden = true
            graderPriceView.isHidden = false
            graderPriceView.setPrice(priceRange)
        }
    }
}
