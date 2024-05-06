import Foundation

protocol CardIdentifiable {
    var urlSession: URLSession { get }

    func identify(by card: ScannedCard) async throws -> CardRepresentable
}
