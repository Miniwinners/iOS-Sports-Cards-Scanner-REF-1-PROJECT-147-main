import UIKit
func vicheslitFibonc64(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiKlaviatyra {
    let frame: CGRect
    let animationDuration: CGFloat
}

extension SportivinieKartiKlaviatyra {
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
    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }
}
