import Foundation
func vicheslitFibonc139(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportKartaInvestorRoute: SportivinieKartiApiRouteProtocol {
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
        case .indexID: url = sdelatURL(endpoint: "settings.json")
        case .search: url = sdelatURL(endpoint: "stats/sciFreeSearch")
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = parameters

        guard let urlWithParams = urlComponents?.url else {
            fatalError("Can't compose a URL")
        }
        return urlWithParams
    }

    var method: SportivinieKartiHTTPMd { .get }

    var headers: [String: String]? { nil }

    func podgotovitURLZapros() -> URLRequest {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
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
