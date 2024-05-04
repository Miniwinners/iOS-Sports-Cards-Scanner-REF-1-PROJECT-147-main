import UIKit
import SnapKit

final class PortfolioInfoView: UIView {

    lazy var cardsValueLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?30:24)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var containerView: UIView = { view in
        view.backgroundColor = .white
        view.layer.cornerRadius = UIDevice.isIpad ? 30 : 24
        return view
    }(UIView())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ?20: 14)
        label.text = L10n.Portfolio.estimatedValue
        label.textColor = .black
        return label
    }(UILabel())

    lazy var cardsLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ?20:14)
        label.text = L10n.Portfolio.cards
        label.textColor = .black
        return label
    }(UILabel())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?30:24)
        label.text = L10n.Portfolio.title
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 30: 24)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    override func layoutSubviews() {
           super.layoutSubviews()
        containerView.makeBorder()
       }

    func setCardsValue(_ cardsValue: Double) {
        cardsValueLabel.text = cardsValue.formattedAsPrice
        cardsValueLabel.setLineHeight(UIDevice.isIpad ?34:28)
        cardsValueLabel.lineBreakMode = .byTruncatingMiddle
    }

    func setCardsNumber(_ number: Int, maxNumber: Int) {
        cardsNumberLabel.text = "\(number)/\(maxNumber)"
        cardsNumberLabel.setLineHeight(UIDevice.isIpad ?34:28)
    }

}

private extension PortfolioInfoView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ?32:26)
        }
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ?20:10)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ?181:148)
        }
        containerView.addSubviews(estimatedValueLabel, cardsLabel)
        estimatedValueLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ?40:30)
            $0.leading.equalToSuperview().inset(UIDevice.isIpad ?30:15)
            $0.height.equalTo(UIDevice.isIpad ?24:18)
        }

        containerView.addSubviews(cardsValueLabel, cardsNumberLabel)
        cardsValueLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(UIDevice.isIpad ?30:15)
            $0.height.equalTo(UIDevice.isIpad ?32:26)
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(5)
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(cardsValueLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ?30:15)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ?40:30)
            $0.height.equalTo(UIDevice.isIpad ?32:26)
        }
        cardsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ?30:15)
            $0.top.equalTo(cardsNumberLabel.snp.bottom).offset(5)
            $0.height.equalTo(UIDevice.isIpad ?26:20)
        }

    }

//    func makeBorder(view: UIView) {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.bounds.insetBy(dx: -0.5, dy: -0.5)
//        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//
//        let shapeLayer = CAShapeLayer()
//        shapeLayer.lineWidth = 1
//        shapeLayer.path = UIBezierPath(roundedRect: view.bounds.insetBy(dx: 0.5, dy: 0.5), cornerRadius: view.layer.cornerRadius).cgPath
//        shapeLayer.strokeColor = UIColor.black.cgColor
//        shapeLayer.fillColor = nil
//
//        gradientLayer.mask = shapeLayer
//
//        view.layer.addSublayer(gradientLayer)
//    }
}
