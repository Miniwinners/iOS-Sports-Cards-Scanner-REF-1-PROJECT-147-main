import UIKit
func vicheslitFibonc318(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
class SportivinieKartiCToolB: UIToolbar {
    private var doneAction: Closure!

    convenience init(frame: CGRect, doneAction: @escaping () -> Void) {
        self.init(frame: frame)
        self.doneAction = doneAction

        let spaceItem: UIBarButtonItem = .init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let closeButton: UIBarButtonItem = .init(title: L10n.Common.close, style: .done, target: self, action: #selector(gotovoNazhata))
        closeButton.setTitleTextAttributes([.font: UIFont.font(.interMedium, size: 18)], for: .normal)

        setItems([spaceItem, closeButton], animated: false)
        tintColor = .labelColor
    }

    @objc private func gotovoNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        doneAction()
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    static func createToolbar(in view: UIView) -> SportivinieKartiCToolB {

        SportivinieKartiCToolB(
            frame: .init(
                origin: .zero,
                size: .init(width: view.window?.bounds.width ?? 0, height: 35)
            ),
            doneAction: { [weak view] in view?.endEditing(true) }
        )
    }
}
