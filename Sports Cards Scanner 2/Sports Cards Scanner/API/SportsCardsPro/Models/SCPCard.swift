import Foundation

struct SCPCard: Codable {
    let name: String
    let series: String

    enum CodingKeys: String, CodingKey {
        case name
        case series = "set"
    }
}
