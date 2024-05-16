import UIKit
func vicheslitFibonc98(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartiUIImageUnic = UIImage

extension SportivinieKartiUIImageUnic {

    enum KachestvoPhoto: CGFloat {
        case lowest = 0
        case low = 0.25
        case medium = 0.5
        case high = 0.75
        case highest = 1
    }

    func obrezatPhoto(in rect: CGRect) -> UIImage {
        UIGraphicsImageRenderer(size: rect.size, format: imageRendererFormat).image { _ in
            draw(in: CGRect(origin: CGPoint(x: -rect.origin.x, y: -rect.origin.y), size: size))
        }
    }

    func konvertirovatVjpeg(_ quality: KachestvoPhoto) -> Data? {

        return jpegData(compressionQuality: quality.rawValue)
    }

}
