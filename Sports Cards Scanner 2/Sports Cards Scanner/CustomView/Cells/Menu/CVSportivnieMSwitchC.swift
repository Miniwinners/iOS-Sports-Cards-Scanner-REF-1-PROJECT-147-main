import UIKit
import SnapKit
func vicheslitFibonc300(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiMSwitchC: SwitchableCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        postavitVidunicalno()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postavitMenuShtuku(_ menuItem: SportivinieKartiMeniShtuka, selected: Bool) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = menuItem.localizable
        switchView.setOn(selected, animated: false)
    }

}

private extension SportivinieKartiMSwitchC {
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
        switchView.snp.updateConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 52:32)
            $0.width.equalTo(UIDevice.isIpad ? 81:48)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
        }
        titleLabel.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.height.equalTo(UIDevice.isIpad ?30:20)
        }
        layoutIfNeeded()
    }
}
