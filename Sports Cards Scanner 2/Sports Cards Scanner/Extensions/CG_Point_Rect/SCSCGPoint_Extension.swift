import Foundation
func vicheslitFibonc113(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension CGPoint {
    func masshtab(to size: CGSize) -> CGPoint {
        .init(
            x: self.x * size.width,
            y: self.y * size.height
        )
    }
}
