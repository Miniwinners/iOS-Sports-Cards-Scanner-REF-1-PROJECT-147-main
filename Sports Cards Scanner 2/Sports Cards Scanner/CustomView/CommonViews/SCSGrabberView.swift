import UIKit
import SnapKit

final class SCSGrabberView: UIView {
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
