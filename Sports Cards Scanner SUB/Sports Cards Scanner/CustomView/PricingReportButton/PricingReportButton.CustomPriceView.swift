import UIKit
import SnapKit

extension PricingReportButton {
    final class CustomPriceView: UIView {

        var type: ButtonTypeReport! {
            didSet {
                setupView()
            }
        }

        lazy var editLabel: UILabel = .init()
        lazy var priceLabel: UILabel = .init()
        lazy var editImageView: UIImageView = .init(image: Images.CollectionMenu.renameCollection.image)

        convenience init(type: ButtonTypeReport) {
            self.init(frame: .zero)
            self.type = type
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
        backgroundColor = .clear
        layer.cornerRadius = 12
        setupView()
    }

    private func setupView() {
        editLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        editLabel.textColor = .black
        addSubview(editLabel)

        addSubview(editImageView)

        priceLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        priceLabel.textColor = .greenColor

        addSubview(priceLabel)

        switch type {
        case .add:
            editImageView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
                make.size.equalTo(UIDevice.isIpad ? 60:32)
                make.centerX.equalToSuperview()
            }
            editLabel.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().inset(UIDevice.isIpad ? 40:30)
                make.height.equalTo(UIDevice.isIpad ? 30:20)
                make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
            priceLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.height.equalTo(UIDevice.isIpad ? 24:18)

            }
        case .main:
            editLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(UIDevice.isIpad ? 18:12)
                $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 22:16)
            }

            editImageView.snp.makeConstraints {
                $0.size.equalTo(UIDevice.isIpad ? 50:24)
                $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 24:16)
                $0.centerY.equalToSuperview()
            }
            priceLabel.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 24:16)
                $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
                $0.height.equalTo(UIDevice.isIpad ? 24:18)
            }
        default: break
        }
    }

}
