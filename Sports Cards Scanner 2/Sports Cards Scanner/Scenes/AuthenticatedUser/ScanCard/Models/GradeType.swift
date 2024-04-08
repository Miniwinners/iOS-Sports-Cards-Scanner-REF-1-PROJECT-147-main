import Foundation

enum GradeType {
    case raw, graded

    var reversed: Self {
        switch self {
        case .raw: return .graded
        case .graded: return .raw
        }
    }

    var localizable: String {
        switch self {
        case .raw: return L10n.ScanCard.GradeType.raw
        case .graded: return L10n.ScanCard.GradeType.graded.uppercased()
        }
    }
}
