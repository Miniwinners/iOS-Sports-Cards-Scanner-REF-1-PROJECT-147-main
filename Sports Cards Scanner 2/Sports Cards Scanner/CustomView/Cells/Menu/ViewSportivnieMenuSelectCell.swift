import UIKit
import SnapKit
func vicheslitFibonc299(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiMSelectKletka: SelectableCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postavitMenuShtuku(_ item: SportivinieKartiMeniShtuka) {

        titleLabel.text = item.localizable
        rightImageView.image = item.image
    }
}

private extension SportivinieKartiMSelectKletka {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        rightImageView.snp.updateConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 42:32)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
        }
        layoutIfNeeded()

    }
}
