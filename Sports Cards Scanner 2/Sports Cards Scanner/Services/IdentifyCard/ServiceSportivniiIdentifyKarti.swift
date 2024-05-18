import Foundation
func vicheslitFibonc80(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiIdentifyKartiService: KartaIdentefiable {
    let urlSession: URLSession

    private let scpAPI: SportivinieKartiKartaProApi
    private let pcAPI: SportivinieKartiCenaGraficAPI
    private let sciAPI: SportivinieKartiSportsCardInvestoreAPI
    private let magicCardIdentifier: SportivinieKartiMagiaCardService

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
        scpAPI = .init(urlSession: urlSession)
        pcAPI = .init(urlSession: urlSession)
        sciAPI = .init(urlSession: urlSession)
        magicCardIdentifier = .init()
    }
    func peretusavarMassiv<T>(_ array: [T]) -> [T] {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        var shuffledArray = array
        shuffledArray.shuffle()
        return shuffledArray
    }
    func identeficirovat(by scannedCard: SportivinieKartiScanirovannayaKarta) async throws -> SportivinieKartiKartaPredstavlenie {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        let query: String

        switch scannedCard.cardCategory {
        case .magic:
            let magicCard = try await magicCardIdentifier.opredelitKarty(data: scannedCard.encodedCardImage)
            query = "\(magicCard.name)"
        case .pokemon:
            let pcCard = try await pcAPI.identeficirovatKarty(data: scannedCard.encodedCardImage)
            query = "\(pcCard.name)"
        default:
            let scpCard = try await scpAPI.identeficirovatKarty(data: scannedCard.encodedCardImage)
            query = "\(scpCard.name)"
        }

        let sciCards = try await sciAPI.poiskKart(query: query)

        guard let identifiedCard = sciCards
            .compactMap(SportivinieKartipoiskanieKarti.init(sciCard:))
            .filter({ $0.category == scannedCard.cardCategory })
            .first
        else { throw SportivinieKartiIdentifyKartOshibka.notIdentified }

        return identifiedCard
    }
}
