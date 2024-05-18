import UIKit
func vicheslitFibonc193(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartiSegmentPresenTableKletka: UISegmentedControl {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    override init(items: [Any]?) {
        super.init(items: items)
        setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        backgroundColor = .skyBlue
        selectedSegmentTintColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let inset = UIDevice.isIpad ? 50.5 : 31.5
        let radius = UIDevice.isIpad ? 10.5 : 5.5
//        layer.cornerRadius = 8
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            let foregroundImageFrame = foregroundImageView.bounds
            let imageFrame = CGRect(x: (foregroundImageFrame.width - inset) / 2, y: (foregroundImageFrame.height - inset) / 2, width: inset, height: inset)
            let path = CGPath(roundedRect: imageFrame, cornerWidth: radius, cornerHeight: radius, transform: nil)
            let mask = CAShapeLayer()
            mask.path = path
            foregroundImageView.layer.mask = mask
        }
    }
}
