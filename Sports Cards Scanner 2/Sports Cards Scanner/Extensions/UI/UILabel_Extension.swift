import UIKit

extension UILabel {
    func setLineHeight(_ lineHeight: CGFloat) {
        let attributedText = self.attributedText ?? NSAttributedString(string: self.text ?? "")
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.lineBreakMode = .byTruncatingTail

        let baselineOffset = abs(lineHeight - font.lineHeight) / 4

        mutableAttributedText.addAttributes(
            [
                .paragraphStyle: paragraphStyle,
                .baselineOffset: baselineOffset
            ],
            range: NSRange(location: 0, length: mutableAttributedText.length)
        )

        self.attributedText = mutableAttributedText
    }
}
