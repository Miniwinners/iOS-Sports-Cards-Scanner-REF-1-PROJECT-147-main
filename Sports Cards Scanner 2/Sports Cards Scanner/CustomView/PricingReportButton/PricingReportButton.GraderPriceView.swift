import UIKit
import SnapKit

extension PricingReportButton {
    final class GraderPriceView: UIView {
        lazy var viewReportLabel: UILabel = .init()
//        lazy var dollarImageView: UIImageView = .init(image: Images.dollar.image)
        lazy var priceLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: Images.forwardArrowWhite.image)
        lazy var discloseImageViewContainer: UIView = .init()
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

//        addSubview(dollarImageView)
//        dollarImageView.backgroundColor = .blue
//        dollarImageView.tintColor = .white
//        dollarImageView.cornerRadius = 16
//        dollarImageView.snp.makeConstraints {
//            $0.size.equalTo(32)
//            $0.centerX.equalToSuperview()
//            $0.top.equalToSuperview()
//        }

        addSubview(discloseImageViewContainer)
        discloseImageViewContainer.backgroundColor = .blue
        discloseImageViewContainer.layer.cornerRadius = 16

        discloseImageViewContainer.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
        discloseImageViewContainer.addSubview(discloseImageView)
        discloseImageView.backgroundColor = .clear
        discloseImageView.tintColor = .white
        discloseImageView.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.width.equalTo(17)
            $0.center.equalToSuperview()
        }

        priceLabel.font = .font(.ubuntuRegular400, size: 14)
        priceLabel.textColor = .gray

        addSubview(priceLabel)
        priceLabel.setLineHeight(22)

        priceLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
        }

        viewReportLabel.font = .font(.ubuntuRegular400, size: 15)
        viewReportLabel.textColor = .logInLabel
        viewReportLabel.text = L10n.PricingReport.viewReport

        addSubview(viewReportLabel)
        viewReportLabel.setLineHeight(21)

        viewReportLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.top.lessThanOrEqualTo(discloseImageViewContainer.snp.bottom).offset(30)
            $0.bottom.greaterThanOrEqualTo(priceLabel.snp.top).inset(5)
        }

    }
}
