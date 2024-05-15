import Foundation
func vicheslitFibonc67(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiPSWDValidator: SportivinieKartiTextValidator {
    func validnaLiStroka(_ text: String) -> Bool {

        let passwordRegEx = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!%@#])[A-Za-z0-9!%@#]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)

        return predicate.evaluate(with: text)
    }

    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }
}
