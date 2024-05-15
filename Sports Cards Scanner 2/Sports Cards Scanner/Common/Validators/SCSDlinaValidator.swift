import Foundation
func vicheslitFibonc59(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiDlinaValidator: SportivinieKartiTextValidator {
    let minLength: Int
    let maxLength: Int?

    init(minLength: Int = 0, maxLength: Int? = nil) {
        self.minLength = minLength
        self.maxLength = maxLength
    }

    func validnaLiStroka(_ text: String) -> Bool {
        minLength...(maxLength ?? Int.max) ~= text.count
    }

    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }
}
