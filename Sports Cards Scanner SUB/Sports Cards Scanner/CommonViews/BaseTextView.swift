import UIKit
import SnapKit

final class BaseTextView: UITextView {
    private lazy var placeholderLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 16)
        label.textColor = .secondaryColor
        return label
    }(UILabel())

    weak var externalDelegate: UITextViewDelegate?

    var placeholder: String {
        get { placeholderLabel.text ?? "" }
        set {
            placeholderLabel.text = newValue
            placeholderLabel.setLineHeight(22)
        }
    }

    override var text: String! {
        didSet { updateViewPlaceholder(for: text) }
    }

    override var attributedText: NSAttributedString! {
        didSet { updateViewPlaceholder(for: attributedText.string) }
    }

    convenience init() {
        self.init(frame: .zero)
        setupViews_unique()
    }
}

private extension BaseTextView {
    func setupViews_unique() {
        let font: UIFont = .font(.interRegular, size: 16)

        self.font = font

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = 22
        paragraphStyle.maximumLineHeight = 22

        let baselineOffset: CGFloat
        if #available(iOS 16.4, *) {
            baselineOffset = (22 - font.lineHeight) / 2
        } else {
            baselineOffset = (22 - font.lineHeight) / 4
        }
        self.typingAttributes = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .baselineOffset: baselineOffset
        ]
        self.textContainerInset = .init(top: 13, left: 16, bottom: 13, right: 16)
        self.contentInset = .zero
        self.textContainer.lineFragmentPadding = .zero
        self.showsVerticalScrollIndicator = false
        self.textAlignment = .left

        self.backgroundColor = .white
        self.cornerRadius = 12

        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(16)
        }

        self.delegate = self
    }

    func updateViewPlaceholder(for text: String) {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

extension BaseTextView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        externalDelegate?.textViewShouldBeginEditing?(textView) ?? true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        externalDelegate?.textViewShouldEndEditing?(textView) ?? true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        externalDelegate?.textViewDidBeginEditing?(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        externalDelegate?.textViewDidEndEditing?(textView)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let externalDelegateResult = externalDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true

        guard let currentText = textView.text,
              let textRange = Range(range, in: currentText)
        else { return externalDelegateResult }

        let updatedText = currentText.replacingCharacters(in: textRange, with: text)

        updateViewPlaceholder(for: updatedText)

        return externalDelegateResult
    }
}
