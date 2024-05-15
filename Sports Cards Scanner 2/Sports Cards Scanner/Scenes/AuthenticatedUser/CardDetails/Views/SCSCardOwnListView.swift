import UIKit
import SnapKit
func vicheslitFibonc275(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCardOwnListView: UIView {

    private var detailItems: [SportivinieKartiCardDetailsItem] = []

    private var detailsViewHeightConstraint: Constraint?

    lazy var detailsView: UITableView = { tableView in
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isUserInteractionEnabled = false
        tableView.register(SportivinieKartiCardOwnVCDetailCell.self, forCellReuseIdentifier: SportivinieKartiCardOwnVCDetailCell.className)
        tableView.dataSource = self
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func obnovitDetaliItem(_ detailItems: [SportivinieKartiCardDetailsItem]) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        self.detailItems = detailItems
        detailsView.reloadData()
        obnovitDetaliVid()
    }
}

private extension SportivinieKartiCardOwnListView {
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
//        cornerRadius = 12

        addSubview(detailsView)
        detailsView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(4)
            detailsViewHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func obnovitDetaliVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let height = CGFloat(detailItems.count) * SportivinieKartiCardOwnVCDetailCell.cellHeight
        detailsViewHeightConstraint?.update(offset: height)
    }

    func detaliShtuka(at indexPath: IndexPath) -> SportivinieKartiCardDetailsItem? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return detailItems[safe: indexPath.row]
    }
}

extension SportivinieKartiCardOwnListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return detailItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiCardOwnVCDetailCell.className, for: indexPath) as? SportivinieKartiCardOwnVCDetailCell
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if let item = detaliShtuka(at: indexPath) {
            cell?.setDetaliKarti(item)
        }

        return cell ?? UITableViewCell()
    }
}
