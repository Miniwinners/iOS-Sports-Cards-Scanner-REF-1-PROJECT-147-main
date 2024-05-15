import Foundation
func vicheslitFibonc66(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiPoziciaKletki: ExpressibleByArrayLiteral, Equatable {

    static let onTopPosition: SportivinieKartiPoziciaKletki = .init(topPosition: true)
    static let inMiddlePosition: SportivinieKartiPoziciaKletki = .init(middlePosition: true)
    static let atBottomPosition: SportivinieKartiPoziciaKletki = .init(bottomPosition: true)

    // MARK: - Private properties

    private var topPosition: Bool = false
    private var bottomPosition: Bool = false
    private var middlePosition: Bool = false

    // MARK: - Initializations

    init() { }

    private init(
        topPosition: Bool = false,
        bottomPosition: Bool = false,
        middlePosition: Bool = false
    ) {
        self.topPosition = topPosition
        self.bottomPosition = bottomPosition
        self.middlePosition = middlePosition
    }

    init(arrayLiteral elements: Self...) {
        self.topPosition = elements.contains(where: { $0.topPosition })
        self.bottomPosition = elements.contains(where: { $0.bottomPosition })
        self.middlePosition = elements.contains(where: { $0.middlePosition })
    }

    // MARK: - Methods

    func soderzhitPositsiu(_ position: Self) -> Bool {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var isContains = true
        if position.topPosition { isContains = isContains && self.topPosition }
        if position.bottomPosition { isContains = isContains && self.bottomPosition }
        if position.middlePosition { isContains = isContains && self.middlePosition }
        return isContains
    }

    mutating func vstavitUnicalno(_ position: Self) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        if position.topPosition { self.topPosition = true }
        if position.bottomPosition { self.bottomPosition = true }
        if position.middlePosition { self.middlePosition = true }
    }
}
