import Foundation

enum CardGrader: String, CaseIterable, Codable, Equatable {
    case RAW
    case CUSTOM
    case CGC, SGC, PSA, ISA, BGS, BVG, CSG, HGA, GMA, RCG
}

extension CardGrader {
    var index: Int {
        CardGrader.allCases.firstIndex(of: self) ?? 0
    }

    var availableGrades: [CardGrade] {
        switch self {
        case .RAW: return []
        case .CUSTOM: return []
        case .CGC: return [.perfect10, .pristine10, .gemMint9Half, .mint9Half] + CardGrader.commonGrades
        case .SGC: return [.pristine10, .gemMint9Half] + CardGrader.commonGrades + [.authentic]
        case .PSA: return [.gemMint10] + CardGrader.commonGrades + [.authentic]
        case .ISA: return [.gemMint10] + CardGrader.commonGrades + [.authentic]
        case .BGS: return [.perfect10, .pristine10, .gemMint9Half] + CardGrader.commonGrades + [.authentic]
        case .BVG: return [.perfect10, .pristine10, .gemMint9Half] + CardGrader.commonGrades + [.authentic]
        case .CSG: return [.perfect10, .pristine10, .gemMint10, .gemMint9Half, .mint9Half] + CardGrader.commonGrades + [.authentic]
        case .HGA: return [.perfect10, .pristine10, .gemMint9Half] + CardGrader.commonGrades + [.authentic]
        case .GMA: return [.gemMint10] + CardGrader.commonGrades + [.authentic]
        case .RCG: return [.perfect10, .pristine10, .gemMint9Half] + CardGrader.commonGrades + [.authentic]
        }
    }

    init?(sciGrade: String) {
        let graderGrade = sciGrade
            .split(separator: " ", maxSplits: 1)
            .compactMap { String($0) }

        guard let sciGrader = graderGrade[safe: 0]?.uppercased(),
              let cardGrader = CardGrader(rawValue: sciGrader)
        else {
            return nil
        }

        self = cardGrader
    }

    private static let commonGrades: [CardGrade] = [.just9, .just8Half, .just8, .just7Half, .just7, .just6Half,
                                                .just6, .just5Half, .just5, .just4Half, .just4, .just3Half,
                                                .just3, .just2Half, .just2, .just1Half, .just1]
}
