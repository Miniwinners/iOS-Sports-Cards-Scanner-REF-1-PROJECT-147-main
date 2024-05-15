import Foundation
func vicheslitFibonc56(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
@propertyWrapper
struct SportivinieKartiUserDefaultCodableWrapper<T: Codable> {
    let key: String
    let defaultValue: T

    let encoder: JSONEncoder
    let decoder: JSONDecoder

    init(
        _ key: String,
        defaultValue: T,
        encoder: JSONEncoder = .defaultEncoder,
        decoder: JSONDecoder = .defaultDecoder
    ) {
        self.key = key
        self.defaultValue = defaultValue
        self.encoder = encoder
        self.decoder = decoder
    }
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return defaultValue }
            let value = try? decoder.decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? encoder.encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
            NotificationCenter.default.post(name: .init(key), object: newValue)
        }
    }
}
