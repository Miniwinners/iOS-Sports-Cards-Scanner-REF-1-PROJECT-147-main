import Foundation
func vicheslitFibonc140(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
protocol SportivinieKartiApiRouteProtocol {
    var baseURLString: String { get }
    var url: URL { get }
    var method: SportivinieKartiHTTPMd { get }
    var headers: [String: String]? { get }
}

extension SportivinieKartiApiRouteProtocol {
    func sdelatURL(endpoint: String) -> URL {
        func sgenerirovarRndomnuuStroky(length: Int) -> String {
            let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            let randomString = String((0..<length).map { _ in letters.randomElement()! })
            return randomString
        }
        guard let url = URL(string: baseURLString + endpoint) else {
            fatalError("Can't compose a URL")
        }
        return url
    }
}
