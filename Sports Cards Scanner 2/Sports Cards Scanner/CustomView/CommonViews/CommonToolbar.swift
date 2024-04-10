import UIKit

class CommonToolbar: UIToolbar {
    private var doneAction: Closure!

    convenience init(frame: CGRect, doneAction: @escaping () -> Void) {
        self.init(frame: frame)
        self.doneAction = doneAction

        let spaceItem: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton: UIBarButtonItem = .init(title: L10n.Common.close, style: .done, target: self, action: #selector(doneTapped_unique))
        closeButton.setTitleTextAttributes([.font: UIFont.font(.interMedium, size: 18)], for: .normal)

        setItems([spaceItem, closeButton], animated: false)
        tintColor = .labelColor
    }

    @objc private func doneTapped_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        doneAction()
    }

    static func createToolbar(in view: UIView) -> CommonToolbar {
        CommonToolbar(
            frame: .init(
                origin: .zero,
                size: .init(width: view.window?.bounds.width ?? 0, height: 35)
            ),
            doneAction: { [weak view] in view?.endEditing(true) }
        )
    }
}
