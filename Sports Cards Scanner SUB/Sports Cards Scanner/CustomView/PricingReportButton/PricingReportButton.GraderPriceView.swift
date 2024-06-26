import UIKit
import SnapKit

extension PricingReportButton {
    final class GraderPriceView: UIView {
        var type: ButtonTypeReport! {
            didSet {
                setupImage()
                setupView()
            }
        }
        lazy var viewReportLabel: UILabel = .init()
        lazy var priceLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: Images.forwardArrowWhite.image)
        lazy var discloseImageViewContainer: UIView = .init()
        convenience init(type: ButtonTypeReport) {
            self.init(frame: .zero)
            self.type = type
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
        backgroundColor = .clear
        layer.cornerRadius = UIDevice.isIpad ? 18:12

        setupImage()
        setupView()

    }

    private func setupView() {
        addSubview(priceLabel)
        priceLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)
        priceLabel.setLineHeight(UIDevice.isIpad ? 24:20)
        addSubview(viewReportLabel)
        viewReportLabel.setLineHeight(UIDevice.isIpad ? 24:20)
        viewReportLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 21:15)
        viewReportLabel.textColor = .logInLabel
        viewReportLabel.text = L10n.PricingReport.viewReport

        switch type {
        case .add:
            priceLabel.textColor = .singINLabel
            viewReportLabel.snp.remakeConstraints {
                $0.top.equalTo(discloseImageViewContainer.snp.bottom).offset(UIDevice.isIpad ? 40:30)
                $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            }
            priceLabel.snp.remakeConstraints {
                $0.top.equalTo(viewReportLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5)
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

        addSubview(discloseImageViewContainer)
        discloseImageViewContainer.addSubview(discloseImageView)

        discloseImageView.image = Images.forwardArrowWhite.image
        discloseImageViewContainer.backgroundColor = .blue
        discloseImageViewContainer.layer.cornerRadius = UIDevice.isIpad ? 20:16

        discloseImageViewContainer.snp.remakeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 40:32)
            switch type {
            case .add:
                layer.borderColor = UIColor.blue.cgColor
                layer.borderWidth = 1
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            case .main:
                layer.borderColor = UIColor.clear.cgColor
                layer.borderWidth = 0
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
