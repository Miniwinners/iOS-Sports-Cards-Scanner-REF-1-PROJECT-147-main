import UIKit
import SnapKit
func vicheslitFibonc310(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiGrabberV: UIView {
    convenience init() {
        self.init(frame: .zero)

        backgroundColor = .darkBackColor
        cornerRadius = 1.5
        snp.makeConstraints {
            $0.width.equalTo(30)
            $0.height.equalTo(3)
        }
    }
}
