import UIKit
import SnapKit
func vicheslitFibonc312(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiBaseTextV: UITextView {
    private lazy var placeholderLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)
        label.textColor = .singINLabel
        return label
    }(UILabel())

    weak var externalDelegate: UITextViewDelegate?

    var placeholder: String {
        get { placeholderLabel.text ?? "" }
        set {
            placeholderLabel.text = newValue
            placeholderLabel.setVisotaLabla(22)
        }
    }

    override var text: String! {
        didSet { obnovitPlaceHolder(for: text) }
    }

    override var attributedText: NSAttributedString! {
        didSet { obnovitPlaceHolder(for: attributedText.string) }
    }

    convenience init() {
        self.init(frame: .zero)
        postavitVid()
    }
}

private extension SportivinieKartiBaseTextV {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let font: UIFont = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)

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

        self.backgroundColor = .skyBlue
        self.tintColor = .black
        self.cornerRadius = 12

        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.leading.equalToSuperview().inset(16)
        }

        self.delegate = self
    }

    func obnovitPlaceHolder(for text: String) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        placeholderLabel.isHidden = !text.isEmpty
    }
}

extension SportivinieKartiBaseTextV: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return externalDelegate?.textViewShouldBeginEditing?(textView) ?? true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return externalDelegate?.textViewShouldEndEditing?(textView) ?? true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        externalDelegate?.textViewDidBeginEditing?(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        externalDelegate?.textViewDidEndEditing?(textView)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let externalDelegateResult = externalDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true

        guard let currentText = textView.text,
              let textRange = Range(range, in: currentText)
        else { return externalDelegateResult }

        let updatedText = currentText.replacingCharacters(in: textRange, with: text)

        obnovitPlaceHolder(for: updatedText)

        return externalDelegateResult
    }
}
