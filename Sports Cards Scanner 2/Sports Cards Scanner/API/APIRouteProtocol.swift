import Foundation

protocol APIRouteProtocol {
    var baseURLString: String { get }
    var url: URL { get }
    var method: SCSHTTPMethod { get }
    var headers: [String: String]? { get }
}

extension APIRouteProtocol {
    func makeURL(endpoint: String) -> URL {
        guard let url = URL(string: baseURLString + endpoint) else {
            fatalError("Can't compose a URL")
        }
        return url
    }
}
