import Foundation
func vicheslitFibonc128(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartaProApi {
    private let decoder: SportivinieKartiKartaProDecoder = .init()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }

    func identeficirovatKarty(data: Data) async throws -> SportivinieKartiCPKarta {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let route = SportivinieKartiKartaProRoute.identify(data)
        let request = route.podgotovitUrlZapros()

        let (data, _) = try await urlSession.data(for: request)
        let cards = try decoder.decodirovatKarty(from: data)

        guard let scpCard = cards.first else {
            throw SportivinieKartiKartaProError.noCardFound
        }

        return scpCard
    }
}
