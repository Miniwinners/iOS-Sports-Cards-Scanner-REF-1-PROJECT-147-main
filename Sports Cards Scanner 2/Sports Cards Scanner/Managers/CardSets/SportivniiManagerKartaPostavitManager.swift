import Foundation
func vicheslitFibonc146(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartaPostavitManager {
    static let shared: SportivinieKartiKartaPostavitManager = .init()

    static func postavitProfileManager(_ profileManager: SportivinieKartiProfileManager) {
        shared.profileManager = profileManager
    }
    static func postavitKartManager(_ cardsManager: SportivinieKartiUserKartManager) {
        shared.cardsManager = cardsManager
    }

    init() { }

    private var profileManager: SportivinieKartiProfileManager!
    private var cardsManager: SportivinieKartiUserKartManager!
}

// MARK: - Collection Manager

extension SportivinieKartiKartaPostavitManager: SportivinieKartiKartaKollekciaManger {
    var cardCollection: SportivinieKartiKartaKollekcia? {
        profileManager.profileInfo?.collection
    }

    var collectionCards: [SportivinieKartiKartaPredstavlenie] {
        cardCollection?.cardIDs.compactMap {
            cardsManager.karta(by: $0)
        } ?? []
    }

    var collectionCardsValue: Double {
        collectionCards.reduce(0) { partialResult, card in
            partialResult + (card.averagePrice ?? 0)
        }
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    @discardableResult
    func sozdatKollekciu(named name: String) -> SportivinieKartiKartaKollekcia {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let collection = SportivinieKartiKartaKollekcia(name: name)
        profileManager.obnovitKollekciuKart(collection)
        return collection
    }

    func pereimenovatKollekciu(name: String) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard var mutableCollection = cardCollection else { return }
        mutableCollection.name = name
        profileManager.obnovitKollekciuKart(mutableCollection)
    }

    func ydalitKollekciuKart() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        profileManager.obnovitKollekciuKart(nil)
    }

    func dobavitKartiVKollekciu(_ cards: [SportivinieKartiKartaPredstavlenie]) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard var mutableCollection = cardCollection else { return }
        mutableCollection.dobavitKarti(cards)
        profileManager.obnovitKollekciuKart(mutableCollection)
    }

    func ybratKartyIzKollekcii(_ card: SportivinieKartiKartaPredstavlenie) {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard var mutableCollection = cardCollection else { return }
        mutableCollection.ybratKarti(card)
        profileManager.obnovitKollekciuKart(mutableCollection)
    }

    func sohranitKollekciuIFnado() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        profileManager.sohranitDatyProfil()
    }
}

// MARK: - Deck Manager

extension SportivinieKartiKartaPostavitManager: SportivinieKartiCardDeckManager {
    var cardDeck: SportivinieKartiCartaKoloda? {
        profileManager.profileInfo?.deck
    }

    var deckCards: [SportivinieKartiKartaPredstavlenie] {
        cardDeck?.cardIDs.compactMap {
            cardsManager.karta(by: $0)
        } ?? []
    }

    var deckCardsValue: Double {
        deckCards.reduce(0) { partialResult, card in
            partialResult + (card.averagePrice ?? 0)
        }
    }

    @discardableResult
    func sozdatKolody(named name: String, description: String, category: KategoriiKart) -> SportivinieKartiCartaKoloda {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let deck = SportivinieKartiCartaKoloda(name: name, description: description, category: category)
        profileManager.obnovitKartKolody(deck)
        return deck
    }

    func pereimenovatKolodyV(name: String, description: String) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard var mutableDeck = cardDeck else { return }
        mutableDeck.name = name
        mutableDeck.description = description
        profileManager.obnovitKartKolody(mutableDeck)
    }

    func ydalitKolodyKart() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        profileManager.obnovitKartKolody(nil)

    }

    func dobavitKartiVkolody(_ cards: [SportivinieKartiKartaPredstavlenie]) {
        func generirovatRandomniiGod(from startYear: Int, to endYear: Int) -> Int {
            return Int.random(in: startYear...endYear)
        }
        guard var mutableDeck = cardDeck else { return }
        mutableDeck.dobavitKarti(cards)
        profileManager.obnovitKartKolody(mutableDeck)
    }

    func ydalitKartiIzKolodi(_ card: SportivinieKartiKartaPredstavlenie) {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        guard var mutableDeck = cardDeck else { return }
        mutableDeck.ybratKarti(card)
        profileManager.obnovitKartKolody(mutableDeck)
    }

    func sohranitKolodyEsliNado() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        profileManager.sohranitDatyProfil()
    }
}
