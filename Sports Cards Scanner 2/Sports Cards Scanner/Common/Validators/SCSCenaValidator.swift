import Foundation
func vicheslitFibonc63(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiCenaValidator: SportivinieKartiTextValidator {
    var maxPriceLength: Int = 255

    func validnaLiStroka(_ text: String) -> Bool {
        let priceRegEx = "^(?:\\$)(?!\\.)(?!0[0-9]+)[0-9]{0,\(maxPriceLength)}(?:\\.[0-9]{0,2})?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", priceRegEx)

        return predicate.evaluate(with: text)
    }

    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }
}
