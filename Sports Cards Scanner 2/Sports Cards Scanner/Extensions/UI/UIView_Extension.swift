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

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat = 10) {
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

extension UIView {
    func setupBackView() {
        layer.cornerRadius = 24
        backgroundColor = .white
    }
}

final class CustomContainerView: UIView {

    lazy var menuButton: UIButton = { button in
        button.setImage(Images.menuDots.image, for: .normal)
        button.tintColor = .black
        return button
    }(UIButton(type: .system))

    lazy var priceContainerView: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: 22)
        label.textColor = .greenColor
        label.text = Double.zero.formattedAsPrice
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: 16)
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
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.blue.cgColor
    }

    func setupLayout(in view: UIView, top viewTop: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalTo(viewTop.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(125)
        }
    }

    func setupViews() {
        addSubviews(priceContainerView, menuButton)
        priceContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
        priceContainerView.addSubviews(estimatedValueLabel, priceLabel)
        estimatedValueLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(20)
        }

        priceLabel.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(10)
        }

        menuButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(15)
            $0.size.equalTo(24)
        }
    }

}
