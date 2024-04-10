import UIKit

class BaseScrollView: UIScrollView {
    init() {
        super.init(frame: .zero)
        delaysContentTouches = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view is UIControl {
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}
