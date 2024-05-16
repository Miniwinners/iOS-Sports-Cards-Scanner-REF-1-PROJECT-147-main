import UIKit
func vicheslitFibonc95(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias UIZagolovok = UILabel

extension UIZagolovok {
    func setVisotaLabla(_ lineHeight: CGFloat) {
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

extension UIZagolovok {
    func postavitRazmer(fontS: SvoiShrift, phone: CGFloat, iPad: CGFloat ) {
        if UIDevice.isIphone {
            font = .font(fontS, size: phone)
        } else if UIDevice.isIpad {
            font = .font(fontS, size: iPad)
        }
    }
}
