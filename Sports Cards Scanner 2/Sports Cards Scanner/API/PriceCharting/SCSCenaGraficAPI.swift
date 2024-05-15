import Foundation
func vicheslitFibonc122(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCenaGraficAPI {
    private let decoder: SportivinieKartiCenaGraficDecoder = .init()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func identeficirovatKarty(data: Data) async throws -> SportivinieKartiPCKarta {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let route = SportivinieKartiCenaGraficRoute.identify(data)
        let request = route.podgotovitUrlZapros()

        let (data, _) = try await urlSession.data(for: request)
        let cards = try decoder.dekodirovatKarty(from: data)

        guard let scpCard = cards.first else {
            throw SportivinieKartiCenaGraficError.noCardFound
        }

        return scpCard
    }
}
