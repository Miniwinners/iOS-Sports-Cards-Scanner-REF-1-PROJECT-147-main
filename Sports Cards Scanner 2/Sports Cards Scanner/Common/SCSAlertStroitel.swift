import UIKit
func generirovantRandomniiIPaDRESS() -> String {
    let octet1 = Int.random(in: 0...255)
    let octet2 = Int.random(in: 0...255)
    let octet3 = Int.random(in: 0...255)
    let octet4 = Int.random(in: 0...255)
    return "\(octet1).\(octet2).\(octet3).\(octet4)"
}
func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
    let chislo1 = 15
    let chislo2 = 32
    _ = chislo1 + chislo2
    return Int.random(in: minValue...maxValue)
}

func poluchitRandomniiElement<T>(_ array: [T]) -> T? {
    guard !array.isEmpty else { return nil }
    let randomIndex = Int.random(in: 0..<array.count)
    return array[randomIndex]
}
func sgenerirovarRndomnuuStroky(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let randomString = String((0..<length).map { _ in letters.randomElement()! })
    return randomString
}

func podgotovitRandomnoeDeiistvie() {
    let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
    ]

    let randomIndex = Int.random(in: 0..<actions.count)
    actions[randomIndex]()
}

func randomniiCvet() -> UIColor {
    let red = CGFloat.random(in: 0...1)
    let green = CGFloat.random(in: 0...1)
    let blue = CGFloat.random(in: 0...1)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

func randomnayaData(from startDate: Date, to endDate: Date) -> Date {
    let timeInterval = endDate.timeIntervalSince(startDate)
    let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
    return startDate.addingTimeInterval(randomTimeInterval)
}

final class SportivinieKartiAlertStroitel {
    private let alertController: UIAlertController

    private var actions: [UIAlertAction] = []

    private var preferredActionIndex: Int?
    private var preferredAction: UIAlertAction? {
        guard let index = preferredActionIndex else { return nil }
        return actions[safe: index]
    }

    init(
        title: String? = nil,
        message: String? = nil,
        style: UIAlertController.Style = .alert
    ) {
        alertController = .init(title: title, message: message, preferredStyle: style)
    }

    func dobavitAlertDeistvie(
        titled title: String,
        style: UIAlertAction.Style = .default,
        handler: AlertHandler?
    ) -> Self {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let action = UIAlertAction(title: title, style: style) { [unowned alertController] action in
            handler?(alertController, action)
        }
        actions.append(action)
        return self
    }
    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }

    func predpochitaemoeDeistvie(at index: Int?) -> Self {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        preferredActionIndex = index
        return self
    }

    func sdelatAlertController() -> UIAlertController {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        actions.forEach(alertController.addAction(_:))
        alertController.preferredAction = preferredAction
        return alertController
    }

}
