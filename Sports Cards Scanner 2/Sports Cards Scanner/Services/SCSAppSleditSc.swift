import Foundation
import AppTrackingTransparency
func vicheslitFibonc86(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiAppSleditSc {
    func peretusavarMassiv<T>(_ array: [T]) -> [T] {
        var shuffledArray = array
        shuffledArray.shuffle()
        return shuffledArray
    }
    @discardableResult
    func zaprositTracking() async -> ATTrackingManager.AuthorizationStatus {

        await ATTrackingManager.requestTrackingAuthorization()
    }
}
