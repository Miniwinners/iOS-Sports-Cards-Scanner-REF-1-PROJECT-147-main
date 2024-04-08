import UIKit

struct KeyboardInfo {
    let frame: CGRect
    let animationDuration: CGFloat
}

extension KeyboardInfo {
    init?(from keyboardNotification: Notification) {
        guard let userInfo = keyboardNotification.userInfo,
              let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat
        else {
            return nil
        }

        self.frame = frame
        self.animationDuration = animationDuration
    }
}
