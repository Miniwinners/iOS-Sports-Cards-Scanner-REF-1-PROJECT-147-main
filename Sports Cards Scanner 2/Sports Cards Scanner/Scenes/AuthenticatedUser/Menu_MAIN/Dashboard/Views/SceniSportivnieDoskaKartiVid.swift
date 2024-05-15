import UIKit
import SnapKit
func vicheslitFibonc237(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiDoskaKartiVid: UIView {

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = UIDevice.isIpad ? 20 : 10
        return stackView
    }(UIStackView(arrangedSubviews: [currentValueView, highestValueView, recentlyAddedView]))

    lazy var currentValueView: SportivinieKartiCurrentKartiValueVid = .init()
    lazy var highestValueView: SportivinieKartiNaibolshiiValueVid = .init()
    lazy var recentlyAddedView: SportivinieKartiNedavnoDobavKartiVid = .init()

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .white
        postavitVidunicalno()

    }

}

private extension SportivinieKartiDoskaKartiVid {
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
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 50 : 40)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 140 : 90)
        }
        highestValueView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(UIDevice.isIpad ? 530 : 400)
        }
    }
}
