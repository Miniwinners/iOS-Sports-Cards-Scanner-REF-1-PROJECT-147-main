import Foundation

enum CardGrade: Codable, Equatable {
    case perfect10, pristine10, gemMint10, just10
    case gemMint9Half, mint9Half, just9Half, just9
    case just8Half, just8
    case just7Half, just7
    case just6Half, just6
    case just5Half, just5
    case just4Half, just4
    case just3Half, just3
    case just2Half, just2
    case just1Half, just1
    case authentic
}

extension CardGrade {
    var name: String {
        switch self {
        case .perfect10: return "Perfect 10"
        case .pristine10: return "Pristine 10"
        case .gemMint10: return "Gem Mint 10"
        case .just10: return "10"
        case .gemMint9Half: return "Gem Mint 9.5"
        case .mint9Half: return "Mint+ 9.5"
        case .just9Half: return "9.5"
        case .just9: return "9"
        case .just8Half: return "8.5"
        case .just8: return "8"
        case .just7Half: return "7.5"
        case .just7: return "7"
        case .just6Half: return "6.5"
        case .just6: return "6"
        case .just5Half: return "5.5"
        case .just5: return "5"
        case .just4Half: return "4.5"
        case .just4: return "4"
        case .just3Half: return "3.5"
        case .just3: return "3"
        case .just2Half: return "2.5"
        case .just2: return "2"
        case .just1Half: return "1.5"
        case .just1: return "1"
        case .authentic: return "Authentic"
        }
    }

    init?(sciValue: String) {
        switch sciValue.lowercased() {
        case "10 perfect", "10 pristine", "10 gem mint", "10 black label", "10": self = .just10
        case "9.5 gem mint", "9.5 mint+", "9.5": self = .just9Half
        case "9": self = .just9
        case "8.5": self = .just8Half
        case "8": self = .just8
        case "7.5": self = .just7Half
        case "7": self = .just7
        case "6.5": self = .just6Half
        case "6": self = .just6
        case "5.5": self = .just5Half
        case "5": self = .just5
        case "4.5": self = .just4Half
        case "4": self = .just4
        case "3.5": self = .just3Half
        case "3": self = .just3
        case "2.5": self = .just2Half
        case "2": self = .just2
        case "1.5": self = .just1Half
        case "1": self = .just1
        default: return nil
        }
    }

    init?(sciGrade: String) {
        let graderGrade = sciGrade
            .split(separator: " ", maxSplits: 1)
            .compactMap { String($0) }

        guard let sciGrade = graderGrade[safe: 1]?.lowercased(),
              let cardGrade = CardGrade(sciValue: sciGrade)
        else {
            return nil
        }

        self = cardGrade
    }
}
