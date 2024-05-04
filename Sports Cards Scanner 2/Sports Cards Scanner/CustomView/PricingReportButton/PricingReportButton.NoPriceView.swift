import UIKit
import SnapKit

extension PricingReportButton {
    final class NoPriceView: UIView {
        lazy var noPriceLabel: UILabel = .init()
        private var type: ButtonTypeReport?
        convenience init(type: ButtonTypeReport) {
            self.init(frame: .zero)
            self.type = type
            setupSubviews_unique()
        }
    }
}

extension PricingReportButton.NoPriceView {
    func setupSubviews_unique() {
        noPriceLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 18:16)
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
                $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 15:5)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 30:20)
            }
        default: break
        }

    }
}
