import UIKit
import SnapKit

extension PricingReportButton {
    final class NoPriceView: UIView {
        lazy var noPriceLabel: UILabel = .init()

        convenience init() {
            self.init(frame: .zero)
            setupSubviews_unique()
        }
    }
}

extension PricingReportButton.NoPriceView {
    func setupSubviews_unique() {
        noPriceLabel.font = .font(.interMedium, size: 18)
        noPriceLabel.textColor = .labelColor
        noPriceLabel.text = L10n.PricingReport.valueEstimating

        addSubview(noPriceLabel)
        noPriceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
