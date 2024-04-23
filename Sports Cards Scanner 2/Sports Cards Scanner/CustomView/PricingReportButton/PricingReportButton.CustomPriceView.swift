import UIKit
import SnapKit

extension PricingReportButton {
    final class CustomPriceView: UIView {
        lazy var editLabel: UILabel = .init()
        lazy var priceLabel: UILabel = .init()
        lazy var editImageView: UIImageView = .init(image: Images.CollectionMenu.renameCollection.image)

        convenience init() {
            self.init(frame: .zero)
            setupSubviews_unique()
        }
    }
}

extension PricingReportButton.CustomPriceView {
    func setPrice(_ price: String?) {
        editLabel.text = price.isNil ? L10n.PricingReport.setCustomPrice : L10n.PricingReport.editCustomPrice
        priceLabel.text = price ?? "-"
    }

    private func setupSubviews_unique() {
        editLabel.font = .font(.ubuntuRegular400, size: 16)
        editLabel.textColor = .black

        addSubview(editLabel)
        editLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        priceLabel.font = .font(.ubuntuRegular400, size: 16)
        priceLabel.textColor = .greenColor

        addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }

        addSubview(editImageView)
        editImageView.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
