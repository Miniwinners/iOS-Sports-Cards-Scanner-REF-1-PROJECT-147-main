import Foundation

struct CardParallel: Codable {
    let name: String
    let imageSource: String?
    let gradersInfo: [CardGrader: GraderInfo]
}

extension CardParallel {
    var imageURL: URL? {
        guard let string = imageSource else { return nil }
        return URL(string: string)
    }
}

extension CardParallel: Equatable {
    static func == (lhs: CardParallel, rhs: CardParallel) -> Bool {
        lhs.name == rhs.name
        && lhs.imageSource == rhs.imageSource
    }
}

// MARK: - Helpers

extension CardParallel {
    static func getParallels(for sciCards: [SCICard]) -> (Self, [Self])? {
        var parallels: [Self] = sciCards.compactMap {
            guard let variation = $0.variation else { return nil }

            return .init(
                name: variation,
                imageSource: $0.imageSource,
                gradersInfo: $0.getGradersInfo()
            )
        }
        guard !parallels.isEmpty else { return nil }

        let firstParallel = parallels.removeFirst()
        let baseParallel: Self = .init(
            name: "-",
            imageSource: firstParallel.imageSource,
            gradersInfo: firstParallel.gradersInfo
        )

        return (baseParallel, parallels)
    }
}
