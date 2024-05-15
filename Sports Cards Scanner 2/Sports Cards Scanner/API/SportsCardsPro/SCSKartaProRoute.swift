import Foundation
func vicheslitFibonc130(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
enum SportivinieKartiKartaProRoute: SportivinieKartiApiRouteProtocol {
    case identify(Data)

    var baseURLString: String { "https://www.sportscardspro.com/" }

    var url: URL { sdelatURL(endpoint: "search-by-photo") }

    var method: SportivinieKartiHTTPMd { .post }

    var headers: [String: String]? { [:] }

    func podgotovitUrlZapros() -> URLRequest {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        var request: URLRequest

        switch self {
        case .identify(let photoData):
            let multipartFormDataRequest = SportivinieKartiMultiDataZapros(url: url)
            multipartFormDataRequest.dobavitTextPole(named: "category", value: "sports-cards")
            multipartFormDataRequest.dobavitDataPole(named: "img", filename: "image.jpeg", data: photoData, mimeType: "image/jpeg")
            request = multipartFormDataRequest.asURLRequest()
        }

        request.httpMethod = method.rawValue
        return request
    }
}
