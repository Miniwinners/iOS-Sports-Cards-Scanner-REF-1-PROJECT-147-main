import UIKit
import SnapKit
func vicheslitFibonc331(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiEsheVid: UIView {

    lazy var profileLogoView: UIImageView = .init(image: SportivinieKartiImages.profileLogo.image)

    lazy var tableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.rowHeight = UIDevice.isIpad ? 70 : UITableView.automaticDimension
        tableView.estimatedRowHeight = 64
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 3
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)

        backgroundColor = .skyBlue
        postavitVidunicalno()
    }

}

private extension SportivinieKartiEsheVid {
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
        addSubview(tableView)
        let headerView = UIView()
        headerView.addSubview(profileLogoView)

        if UIDevice.isIphone {
            tableView.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide)
                $0.horizontalEdges.equalToSuperview()
                $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            }

            headerView.frame.size.height = 140

            profileLogoView.snp.makeConstraints {
                $0.size.equalTo(UIDevice.isIpad ? 197:109)
                $0.top.equalToSuperview().inset(20)
                $0.centerX.equalToSuperview()
            }

        } else if UIDevice.isIpad {
            tableView.snp.makeConstraints {
                $0.top.equalTo(safeAreaLayoutGuide).inset(20)
                $0.horizontalEdges.equalToSuperview().inset(80)
                $0.bottom.equalTo(safeAreaLayoutGuide).inset(70)
            }
            headerView.frame.size.height = 260

            profileLogoView.snp.makeConstraints {
                $0.size.equalTo(197)
                $0.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
                $0.centerX.equalToSuperview()
            }
        }
        tableView.tableHeaderView = headerView

    }

}
