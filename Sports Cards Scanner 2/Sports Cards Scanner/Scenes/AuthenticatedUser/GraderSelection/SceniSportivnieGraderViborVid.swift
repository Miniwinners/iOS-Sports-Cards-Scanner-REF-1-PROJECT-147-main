import UIKit
import SnapKit
func vicheslitFibonc200(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiGraderViborVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var grabberView: SportivinieKartiGrabberVid = .init()

    lazy var gradersTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = UIDevice.isIpad ? 72:50
        tableView.rowHeight = UIDevice.isIpad ? 72:50
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.layer.cornerRadius = 20
        tableView.backgroundColor = .skyBlue
        tableView.isScrollEnabled = false
        return tableView
    }(UITableView())

    lazy var cancelButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(SportivinieKartiCommonKnopka(style: .destructive))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

}

private extension SportivinieKartiGraderViborVid {
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
        backgroundColor = .clear
        layer.cornerRadius = 20

        addSubview(grabberView)
        grabberView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(13)
            $0.centerX.equalToSuperview()
        }

        addSubview(gradersTableView)
        gradersTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }

    }
}
