import UIKit
import SnapKit
func vicheslitFibonc316(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
class SportivinieKartiCTExtF: UITextField {
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
                    .foregroundColor: UIColor.singINLabel,
                    .font: UIFont.font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)

                ]
            )
        }
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    @discardableResult
    func postavirPhotoUnicalno(_ image: UIImage, paddings: UIEdgeInsets = .zero) -> UIImageView {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let containerView = UIView()
        let imageView = UIImageView(image: image)
        containerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(paddings.top)
            $0.leading.equalToSuperview().inset(paddings.left)
            $0.trailing.equalToSuperview().inset(paddings.right)
            $0.bottom.equalToSuperview().inset(paddings.bottom)
            $0.size.equalTo(UIDevice.isIpad ? 40 : 28)
        }
        rightView = containerView

        return imageView
    }
}
