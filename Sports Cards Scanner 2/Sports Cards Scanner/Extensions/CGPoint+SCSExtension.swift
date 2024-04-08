import Foundation

extension CGPoint {
    func scaled(to size: CGSize) -> CGPoint {
        .init(
            x: self.x * size.width,
            y: self.y * size.height
        )
    }
}
