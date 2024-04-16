import UIKit
import SnapKit

final class PricingReportButton: UIButton {

    lazy var noPriceView: NoPriceView = .init()
    lazy var customPriceView: CustomPriceView = .init()
    lazy var graderPriceView: GraderPriceView = .init()

    enum ReportMode {
        case noPrice
        case customPrice(price: String?)
        case graderPrice(priceRange: String)
    }

    var reportMode: ReportMode? {
        didSet { reportModeDidUpdate() }
    }

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
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
        cornerRadius = 12
        borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor

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
