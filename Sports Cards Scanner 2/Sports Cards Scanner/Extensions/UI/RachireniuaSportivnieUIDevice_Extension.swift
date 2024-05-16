import UIKit
func vicheslitFibonc96(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension UIDevice {
    static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
    static let isIpad = UIDevice.current.userInterfaceIdiom == .pad
}
