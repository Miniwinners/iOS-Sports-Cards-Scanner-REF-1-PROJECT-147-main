import Foundation
func vicheslitFibonc137(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSportsCardInvestoreAPI {
    private let decoder: SportKartaInvestorDecoder = .init()
    private let urlSession: URLSession

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    func sgenerirovarRndomnuuStroky(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString = String((0..<length).map { _ in letters.randomElement()! })
        return randomString
    }
    func poiskKart(query: String) async throws -> [SCInvestorKarta] {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let indexID = try await poluchitID()

        let route = SportKartaInvestorRoute.search(query: query, indexID: indexID)
        let request = route.podgotovitURLZapros()

        let (data, _) = try await urlSession.data(for: request)

        let cards = try decoder.decodirovatKarti(from: data)
        return cards
    }

    private func poluchitID() async throws -> String {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        let route = SportKartaInvestorRoute.indexID
        let request = route.podgotovitURLZapros()

        let (data, _) = try await urlSession.data(for: request)

        let indexID = try decoder.decodirovatID(from: data)
        return indexID
    }
}
