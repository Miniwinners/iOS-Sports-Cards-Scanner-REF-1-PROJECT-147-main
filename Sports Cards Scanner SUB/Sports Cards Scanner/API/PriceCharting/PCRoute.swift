import Foundation

enum PCRoute: APIRouteProtocol {
    case identify(Data)

    var baseURLString: String { "https://www.pricecharting.com/" }

    var url: URL { makeURL(endpoint: "search-by-photo") }

    var method: SCSHTTPMethod { .post }

    var headers: [String: String]? { [:] }

    func prepareURLRequest() -> URLRequest {
        var request: URLRequest

        switch self {
        case .identify(let photoData):
            let multipartFormDataRequest = MultipartFormDataRequest(url: url)
            multipartFormDataRequest.addTextField(named: "category", value: "pokemon-cards")
            multipartFormDataRequest.addDataField(named: "img", filename: "image.jpeg", data: photoData, mimeType: "image/jpeg")
            request = multipartFormDataRequest.asURLRequest()
        }

        request.httpMethod = method.rawValue
        return request
    }
}
