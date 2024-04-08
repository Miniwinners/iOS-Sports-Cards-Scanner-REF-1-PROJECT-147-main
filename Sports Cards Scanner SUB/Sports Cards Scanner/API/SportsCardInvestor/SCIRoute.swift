import Foundation

enum SCIRoute: APIRouteProtocol {
    case indexID
    case search(query: String, indexID: String)

    var baseURLString: String {
        switch self {
        case .indexID:
            return "https://scour-index-prod.s3.us-east-2.amazonaws.com/"
        case .search:
            return "https://api.sportscardinvestor.com/"
        }
    }

    var url: URL {
        let url: URL
        switch self {
        case .indexID: url = makeURL(endpoint: "settings.json")
        case .search: url = makeURL(endpoint: "stats/sciFreeSearch")
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters

        guard let urlWithParams = urlComponents?.url else {
            fatalError("Can't compose a URL")
        }
        return urlWithParams
    }

    var method: SCSHTTPMethod { .get }

    var headers: [String: String]? { nil }

    func prepareURLRequest() -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters

        let url = urlComponents?.url ?? self.url

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }

    private var parameters: [URLQueryItem]? {
        switch self {
        case .indexID:
            return nil
        case .search(let query, let indexID):
            return [
                .init(name: "query", value: query),
                .init(name: "index_id", value: indexID)
            ]
        }
    }
}
