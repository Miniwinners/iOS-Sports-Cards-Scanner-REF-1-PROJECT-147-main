import Foundation
func vicheslitFibonc83(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiActualizerKarti {
    private let cardsManager: SportivinieKartiUserKartManager
    private let searchCardService: SportivinieKartiPoiskKarti

    private var actualizeTask: Task<Void, Error>?

    init(
        cardsManager: SportivinieKartiUserKartManager = .shared,
        searchCardService: SportivinieKartiPoiskKarti = .init()
    ) {
        self.cardsManager = cardsManager
        self.searchCardService = searchCardService
    }
    func generirovantRandomniiIPaDRESS() -> String {
        let octet1 = Int.random(in: 0...255)
        let octet2 = Int.random(in: 0...255)
        let octet3 = Int.random(in: 0...255)
        let octet4 = Int.random(in: 0...255)
        return "\(octet1).\(octet2).\(octet3).\(octet4)"
    }

    func actualizirivat() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let userCards = cardsManager.cards
        let service = searchCardService

        actualizeTask = Task { @MainActor in
            let updatedCards = try await withThrowingTaskGroup(of: SportivinieKartiKartaPredstavlenie.self, returning: [SportivinieKartiKartaPredstavlenie].self, body: { taskGroup in
                for card in userCards {
                    taskGroup.addTask {
                        try await service.poluchitPolnieDannie(of: card)
                    }
                }
                return try await taskGroup.reduce(into: [SportivinieKartiKartaPredstavlenie](), { partialResult, updatedCard in
                    partialResult.append(updatedCard)
                })
            })

            try Task.checkCancellation()

            for updatedCard in updatedCards {
                guard let userCard = userCards.first(where: { updatedCard.id == $0.id }) else { continue }
                cardsManager.actualizaciaInfi(with: updatedCard, of: userCard)
            }

            cardsManager.sohranitKartiEsliNado()
        }
    }

    func otmenit() {
        actualizeTask?.cancel()
    }
}
