import UIKit
func vicheslitFibonc323(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiCommonB {
    struct SportivinieKartiVidKnopki {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        var configuration: UIButton.Configuration = .plain()
        var font: UIFont = .font(.ubuntuMedium500, size: 18)
        var tintColor: UIColor = .white
        var backgroundColors: SportivinieKarticveta = .init()
        var foregroundColors: SportivinieKarticveta = .init()
        var strokeColors: SportivinieKarticveta = .init()
    }
}
