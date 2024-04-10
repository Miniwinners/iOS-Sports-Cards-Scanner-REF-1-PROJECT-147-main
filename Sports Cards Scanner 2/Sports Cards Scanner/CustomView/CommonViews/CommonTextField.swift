import UIKit
import SnapKit

class CommonTextField: UITextField {
    private var padding: UIEdgeInsets {
        .init(top: 0, left: leadingPadding, bottom: 0, right: trailingPadding)
    }

    var leadingPadding: CGFloat = 16
    var trailingPadding: CGFloat = 16

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override var placeholder: String? {
        get { attributedPlaceholder?.string ?? "" }
        set {
            attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: [
                    .foregroundColor: UIColor.logInLabel,
                    .font: UIFont.font(.ubuntuLight300, size: 16)
                ]
            )
        }
    }

    @discardableResult
    func setRightImage_unique(_ image: UIImage, paddings: UIEdgeInsets = .zero) -> UIImageView {
        let containerView = UIView()
        let imageView = UIImageView(image: image)
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(paddings.top)
            $0.leading.equalToSuperview().inset(paddings.left)
            $0.trailing.equalToSuperview().inset(paddings.right)
            $0.bottom.equalToSuperview().inset(paddings.bottom)
        }
        rightView = containerView

        return imageView
    }
}
