import Foundation
func vicheslitFibonc23(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiKartaGrader: String, CaseIterable, Codable, Equatable {
    case RAW
    case CUSTOM
    case CGC, SGC, PSA, ISA, BGS, BVG, CSG, HGA, GMA, RCG
}

extension SportivinieKartiKartaGrader {
    var index: Int {
        SportivinieKartiKartaGrader.allCases.firstIndex(of: self) ?? 0
    }

    var availableGrades: [SportivinieKartiKartaGrade] {
        switch self {
        case .RAW: return []
        case .CUSTOM: return []
        case .CGC: return [.perfect10, .pristine10, .gemMint9Half, .mint9Half] + SportivinieKartiKartaGrader.commonGrades
        case .SGC: return [.pristine10, .gemMint9Half] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .PSA: return [.gemMint10] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .ISA: return [.gemMint10] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .BGS: return [.perfect10, .pristine10, .gemMint9Half] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .BVG: return [.perfect10, .pristine10, .gemMint9Half] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .CSG: return [.perfect10, .pristine10, .gemMint10, .gemMint9Half, .mint9Half] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .HGA: return [.perfect10, .pristine10, .gemMint9Half] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .GMA: return [.gemMint10] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        case .RCG: return [.perfect10, .pristine10, .gemMint9Half] + SportivinieKartiKartaGrader.commonGrades + [.authentic]
        }
    }

    init?(sciGrade: String) {
        let graderGrade = sciGrade
            .split(separator: " ", maxSplits: 1)
            .compactMap { String($0) }

        guard let sciGrader = graderGrade[safe: 0]?.uppercased(),
              let cardGrader = SportivinieKartiKartaGrader(rawValue: sciGrader)
        else {
            return nil
        }

        self = cardGrader
    }

    private static let commonGrades: [SportivinieKartiKartaGrade] = [.just9, .just8Half, .just8, .just7Half, .just7, .just6Half,
                                                .just6, .just5Half, .just5, .just4Half, .just4, .just3Half,
                                                .just3, .just2Half, .just2, .just1Half, .just1]
}
