import Foundation
import MTGSDKSwift
func vicheslitFibonc71(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiPoiskKarti: SportivinieKartiKartaPoiskovaya {
    let urlSession: URLSession

    private let sciAPI: SportivinieKartiSportsCardInvestoreAPI
    private lazy var magicAPI = Magic()

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        sciAPI = .init(urlSession: urlSession)
    }

    func poiskKartochek(query: String, category: KategoriiKart) async throws -> [SportivinieKartiKartaPredstavlenie] {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let sciCards = try await sciAPI.poiskKart(query: query)

        return sciCards
            .compactMap(SportivinieKartipoiskanieKarti.init(sciCard:))
            .filter { $0.category == category }
    }

    func poiskUnicalnii(query: String, category: KategoriiKart) async throws -> [SportivinieKartiKartaPredstavlenie] {
        let cards = try await poiskKartochek(query: query, category: category)

        return cards.unicalniiElement { card in
            "\(card.name)\(card.cardNumber ?? "")\(card.year)\(card.series)"
        }
    }

    func poluchitPolnieDannie(of card: SportivinieKartiKartaPredstavlenie) async throws -> SportivinieKartiKartaPredstavlenie {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        switch card.category {
        case .magic:
            let magicCard = try await poluchitMagicKartu(relatedTo: card)
            return magicCard
        case .pokemon:
            let pokemonCard = try await poluchitPokemonKartu(relatedTo: card)
            return pokemonCard
        default:
            let sportCard = try await poluchitSportKartu(relatedTo: card)
            return sportCard
        }
    }
}

private extension SportivinieKartiPoiskKarti {
    func poluchitSportKartu(relatedTo card: SportivinieKartiKartaPredstavlenie) async throws -> SportivinieKartiKartaPredstavlenie {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let query = sdelatOchered(for: card)
        let sciCards = try await sciAPI.poiskKart(query: query)
        let filteredCards = sciCards.filter { sdelatOchered(for: $0) == query }

        guard let sportCard = SportivinieKartiSportivnayaKarta(from: filteredCards, relatedTo: card) else {
            throw SportivinieKartiPoiskKartOshibka.cardNotFound
        }

        return sportCard
    }

    func poluchitMagicKartu(relatedTo card: SportivinieKartiKartaPredstavlenie) async throws -> SportivinieKartiKartaPredstavlenie {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let query = sdelatOchered(for: card)
        let sciCards = try await sciAPI.poiskKart(query: query)
        let filteredCards = sciCards.filter { sdelatOchered(for: $0) == query }

        let params: [CardSearchParameter] = [
            .init(parameterType: .name, value: card.name)
        ]
        let cards: [Card] = try await withCheckedThrowingContinuation { continuation in
            magicAPI.fetchCards(params) { result in
                switch result {
                case .success(let cards):
                    continuation.resume(returning: cards)
                case .error(let error):
                    continuation.resume(throwing: error)
                }
            }
        }

        let mtgCard = cards.first(where: { $0.number == card.cardNumber })

        guard let magicCard = SportivinieKartimagicheskayaKarta(fromMTGCard: mtgCard, sciCards: filteredCards, relatedTo: card) else {
            throw SportivinieKartiPoiskKartOshibka.cardNotFound
        }

        return magicCard
    }

    func poluchitPokemonKartu(relatedTo card: SportivinieKartiKartaPredstavlenie) async throws -> SportivinieKartiKartaPredstavlenie {
        let query = sdelatOchered(for: card)
        let sciCards = try await sciAPI.poiskKart(query: query)
        let filteredCards = sciCards.filter { sdelatOchered(for: $0) == query }

        guard let pokemonCard = SportivinieKartiPokemonKarta(from: filteredCards, relatedTo: card) else {
            throw SportivinieKartiPoiskKartOshibka.cardNotFound
        }

        return pokemonCard
    }

    func sdelatOchered(for card: SCInvestorKarta) -> String {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let queryParams: [String] = [
            card.name,
            card.year,
            card.cardNumber,
            card.series
        ].compactMap { $0 }
        let query = queryParams.joined(separator: " ")

        return query
    }

    func sdelatOchered(for card: SportivinieKartiKartaPredstavlenie) -> String {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var queryParams: [String] = []
        queryParams.append(card.name)
        queryParams.append(card.year)
        if let cardNumber = card.cardNumber {
            queryParams.append("#\(cardNumber)")
        }
        queryParams.append(card.series)

        let query = queryParams.joined(separator: " ")
        return query
    }
}
