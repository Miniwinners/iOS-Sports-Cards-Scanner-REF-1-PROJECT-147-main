import UIKit
import SnapKit

extension UIView {
    var borderColor: UIColor {
        get { UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }

    var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat = 0) {
        let cornerMask = convertCornersToMask(corners)

        layer.cornerRadius = radius
        layer.maskedCorners = cornerMask
    }

    private func convertCornersToMask(_ corners: UIRectCorner) -> CACornerMask {
        var cornerMask = CACornerMask()

        if corners.contains(.allCorners) { cornerMask.insert([.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]) }
        if corners.contains(.topLeft) { cornerMask.insert(.layerMinXMinYCorner) }
        if corners.contains(.topRight) { cornerMask.insert(.layerMaxXMinYCorner) }
        if corners.contains(.bottomLeft) { cornerMask.insert(.layerMinXMaxYCorner) }
        if corners.contains(.bottomRight) { cornerMask.insert(.layerMaxXMaxYCorner) }

        return cornerMask
    }
}

final class CustomContainerView: UIView {

    lazy var priceContainerView: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.setSize(fontS: .ubuntuMedium500, phone: 22, iPad: 28)
        label.textColor = .greenColor
        label.text = Double.zero.formattedAsPrice
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22 : 16)
        label.textColor = .black
        label.text = L10n.CardCollection.estimatedValue
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupContainerView() {
        backgroundColor = .skyBlue
        layer.cornerRadius = UIDevice.isIpad ? 24:16
    }

    func setupLayout(in view: UIView, top viewTop: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalTo(viewTop.snp.bottom).offset(UIDevice.isIpad ? 40 : 20)
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
            make.height.equalTo(UIDevice.isIpad ? 180 : 110)
        }
    }

    func setupViews() {
        addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIDevice.isIpad ? 100 : 60)
        }
        priceContainerView.addSubviews(estimatedValueLabel, priceLabel)
        estimatedValueLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ?  30 :20)
        }

        priceLabel.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(10)
        }

    }

}

extension UIView {
    func makeBorder() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds.insetBy(dx: -0.5, dy: -0.5)
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.contentsScale = UIScreen.main.scale

        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1
        let adjustedBounds = self.bounds.insetBy(dx: 0.5, dy: 0.5)
        shapeLayer.path = UIBezierPath(roundedRect: adjustedBounds, cornerRadius: self.layer.cornerRadius).cgPath
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.fillColor = nil
        shapeLayer.contentsScale = UIScreen.main.scale
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round

        gradientLayer.mask = shapeLayer

        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale

        self.layer.addSublayer(gradientLayer)
    }
}
