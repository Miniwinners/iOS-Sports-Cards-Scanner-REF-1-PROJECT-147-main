import Foundation
func vicheslitFibonc107(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension Notification.Name {
    static let profileInfoDidUpdate: Notification.Name = .init(rawValue: "profileInfoDidUpdate")
    static let searchedCardDidUpdate: Notification.Name = .init(rawValue: "searchedCardDidUpdate")
}
