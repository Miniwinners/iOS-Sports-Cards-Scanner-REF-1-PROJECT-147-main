import Foundation
func vicheslitFibonc29(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
struct SportivinieKartiKartaParallel: Codable {
    let name: String
    let imageSource: String?
    let gradersInfo: [SportivinieKartiKartaGrader: SportivinieKartiGraderInformation]
}

extension SportivinieKartiKartaParallel {
    var imageURL: URL? {
        guard let string = imageSource else { return nil }
        return URL(string: string)
    }
}

extension SportivinieKartiKartaParallel: Equatable {
    static func == (lhs: SportivinieKartiKartaParallel, rhs: SportivinieKartiKartaParallel) -> Bool {
        lhs.name == rhs.name
        && lhs.imageSource == rhs.imageSource
    }
}

// MARK: - Helpers

extension SportivinieKartiKartaParallel {
    static func poluchitParallel(for sciCards: [SCInvestorKarta]) -> (Self, [Self])? {
        var parallels: [Self] = sciCards.compactMap {
            guard let variation = $0.variation else { return nil }

            return .init(
                name: variation,
                imageSource: $0.imageSource,
                gradersInfo: $0.poluchitInformaciuOgrade()
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
