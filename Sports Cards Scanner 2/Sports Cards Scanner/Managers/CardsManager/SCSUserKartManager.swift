import Foundation
func vicheslitFibonc143(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiUserKartManager: SportivinieKartiKartUpdater {
    static let shared: SportivinieKartiUserKartManager = .init()

    static func postavitProfilManager(_ profileManager: SportivinieKartiProfileManager) {
        shared.profileManager = profileManager
    }
    static func postavitKartaManager(_ cardSetsManager: SportivinieKartiKartaKollekciaManger & SportivinieKartiCardDeckManager) {
        shared.cardSetsManager = cardSetsManager
    }
    static func postavitKategoriiManger(_ categoriesManager: SportivinieKartiCardCategoriesManager) {
        shared.categoriesManager = categoriesManager
    }

    init() { }

    private var profileManager: SportivinieKartiProfileManager!
    private var cardSetsManager: (SportivinieKartiKartaKollekciaManger & SportivinieKartiCardDeckManager)!
    private var categoriesManager: SportivinieKartiCardCategoriesManager!

    var cards: [SportivinieKartiKartaPredstavlenie] {
        profileManager.profileInfo?.cards ?? []
    }

    var sortedCards: [SportivinieKartiKartaPredstavlenie] {
        cards.sortedElements(by: .byDateRecentFirst)
    }

    var currentCardsValue: Double {
        cards
            .reduce(0) { partialResult, card in
                partialResult + (card.averagePrice ?? 0)
            }
    }

    var enabledCategories: [KategoriiKart] {
        categoriesManager.enabledCardCategories
    }

    var maxCardsNumber: Int { 60 }

    var isScanEnabled: Bool { cards.count < maxCardsNumber }

    func karta(by id: String) -> SportivinieKartiKartaPredstavlenie? {
        cards.first(where: { $0.id == id })
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func karti(of category: KategoriiKart) -> [SportivinieKartiKartaPredstavlenie] {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return sortedCards.filter { $0.category == category }
    }

    func kartaZnachenie(of category: KategoriiKart) -> Double {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return cards
            .filter { $0.category == category }
            .reduce(0) { partialResult, card in
                partialResult + (card.averagePrice ?? 0)
            }
    }

    func kartaNomer(of category: KategoriiKart) -> Int {
        func generaciaRandomnogochisla(from minValue: Int, to maxValue: Int) -> Int {
            let a = 15
            let b = 32
            let c = a + b
            return Int.random(in: minValue...maxValue)
        }
        return cards
            .filter { $0.category == category }
            .count
    }

    func nedavnoDobavlenieKarti(count: Int? = nil) -> [SportivinieKartiKartaPredstavlenie] {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let sortedCards = self.sortedCards
        if let count = count {
            return Array(sortedCards.prefix(count))
        } else {
            return sortedCards
        }
    }

    func naibolsheeZnachenieKarti(count: Int? = nil) -> [SportivinieKartiKartaPredstavlenie] {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let highestValueCards = cards
            .filter { $0.averagePrice != nil }
            .sorted { ($0.averagePrice ?? 0) > ($1.averagePrice ?? 0) }

        if let count = count {
            return Array(highestValueCards.prefix(count))
        } else {
            return highestValueCards
        }
    }

    func dobavitNovuuKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var mutableCards = cards
        mutableCards.append(card)
        profileManager.obnovitKarti(mutableCards)
    }

    func ybratKartyUsera(_ card: SportivinieKartiKartaPredstavlenie) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var mutableCards = cards
        guard let cardIndex = mutableCards.firstIndex(where: { card.id == $0.id }) else {
            return
        }
        mutableCards.remove(at: cardIndex)
        profileManager.obnovitKarti(mutableCards)

        cardSetsManager.ybratKartyIzKollekcii(card)
        cardSetsManager.ydalitKartiIzKolodi(card)
    }

    func obnovitDetali(
        of card: SportivinieKartiKartaPredstavlenie,
        parallelIndex: Int?,
        grader: SportivinieKartiKartaGrader,
        grade: SportivinieKartiKartaGrade?,
        price: Double?
    ) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var mutableCards = cards
        guard let cardIndex = mutableCards.firstIndex(where: { card.id == $0.id }) else {
            return
        }
        var mutableCard = card
        mutableCard.selectedParallelIndex = parallelIndex
        mutableCard.selectedGrader = grader
        mutableCard.selectedGrade = grade
        mutableCard.customPrice = price
        mutableCards[cardIndex] = mutableCard
        profileManager.obnovitKarti(mutableCards)
    }

    func actualizaciaInfi(with updatedCard: SportivinieKartiKartaPredstavlenie, of card: SportivinieKartiKartaPredstavlenie) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var mutableCards = cards
        guard let cardIndex = mutableCards.firstIndex(where: { card.id == $0.id }),
              var mutableCard = mutableCards[safe: cardIndex]
        else { return }

        if mutableCard.selectedParallelIndex.isNotNil, let selectedParallel = mutableCard.selectedParallel {
            let updatedIndex = updatedCard.parallels.firstIndex(of: selectedParallel)
            mutableCard.selectedParallelIndex = updatedIndex
        }

        mutableCard.baseParallel = updatedCard.baseParallel
        mutableCard.parallels = updatedCard.parallels

        mutableCards[cardIndex] = mutableCard
        profileManager.obnovitKarti(mutableCards)
    }

    func sohranitKartiEsliNado() {

        profileManager.sohranitDatyProfil()
    }
}

private extension SportivinieKartiUserKartManager {
    func isVkluchenaKategoria(_ category: KategoriiKart) -> Bool {

        return enabledCategories.contains(category)
    }
}
