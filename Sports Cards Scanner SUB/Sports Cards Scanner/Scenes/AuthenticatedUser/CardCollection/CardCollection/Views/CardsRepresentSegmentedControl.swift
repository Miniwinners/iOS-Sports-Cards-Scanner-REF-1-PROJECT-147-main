import UIKit

final class CardsRepresentSegmentedControl: UISegmentedControl {
    override init(items: [Any]?) {
        super.init(items: items)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        backgroundColor = .backColor
        selectedSegmentTintColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 8
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            let foregroundImageFrame = foregroundImageView.bounds
            let imageFrame = CGRect(x: (foregroundImageFrame.width - 31.5) / 2, y: (foregroundImageFrame.height - 31.5) / 2, width: 31.5, height: 31.5)
            let path = CGPath(roundedRect: imageFrame, cornerWidth: 5.25, cornerHeight: 5.25, transform: nil)
            let mask = CAShapeLayer()
            mask.path = path
            foregroundImageView.layer.mask = mask
        }
    }
}
