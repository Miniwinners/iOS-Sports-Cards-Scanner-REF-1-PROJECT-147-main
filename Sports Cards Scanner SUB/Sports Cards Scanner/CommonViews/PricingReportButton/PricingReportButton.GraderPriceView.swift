import UIKit
import SnapKit

extension PricingReportButton {
    final class GraderPriceView: UIView {
        lazy var viewReportLabel: UILabel = .init()
        lazy var dollarImageView: UIImageView = .init(image: Images.dollar.image)
        lazy var priceLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: Images.forwardArrow.image)

        convenience init() {
            self.init(frame: .zero)
            setupSubviews_unique()
        }
    }
}

extension PricingReportButton.GraderPriceView {
    func setPrice(_ priceRange: String) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        priceLabel.text = priceRange
    }

    private func setupSubviews_unique() {
        viewReportLabel.font = .font(.interMedium, size: 16)
        viewReportLabel.textColor = .labelColor
        viewReportLabel.text = L10n.PricingReport.viewReport

        addSubview(viewReportLabel)
        viewReportLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        addSubview(dollarImageView)
        dollarImageView.snp.makeConstraints {
            $0.size.equalTo(19)
            $0.leading.equalTo(viewReportLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(viewReportLabel)
        }

        priceLabel.font = .font(.interMedium, size: 20)
        priceLabel.textColor = .greenColor

        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }

        addSubview(discloseImageView)
        discloseImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
