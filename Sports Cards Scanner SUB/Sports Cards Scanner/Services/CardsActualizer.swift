import Foundation

final class CardsActualizer {
    private let cardsManager: UserCardsManager
    private let searchCardService: SearchCardService

    private var actualizeTask: Task<Void, Error>?

    init(
        cardsManager: UserCardsManager = .shared,
        searchCardService: SearchCardService = .init()
    ) {
        self.cardsManager = cardsManager
        self.searchCardService = searchCardService
    }

    func actualize() {
        let userCards = cardsManager.cards
        let service = searchCardService

        actualizeTask = Task { @MainActor in
            let updatedCards = try await withThrowingTaskGroup(of: CardRepresentable.self, returning: [CardRepresentable].self, body: { taskGroup in
                for card in userCards {
                    taskGroup.addTask {
                        try await service.getFullInfo(of: card)
                    }
                }
                return try await taskGroup.reduce(into: [CardRepresentable](), { partialResult, updatedCard in
                    partialResult.append(updatedCard)
                })
            })

            try Task.checkCancellation()

            for updatedCard in updatedCards {
                guard let userCard = userCards.first(where: { updatedCard.id == $0.id }) else { continue }
                cardsManager.actualizeInfo(with: updatedCard, of: userCard)
            }

            cardsManager.saveCardsIfNeeded()
        }
    }

    func cancel() {
        actualizeTask?.cancel()
    }
}
