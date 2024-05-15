import UIKit
import SnapKit
func vicheslitFibonc168(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCenaOcenkaVide: UIView {

    lazy var detailsView: SportivinieKartiCenaOcenkaDetaliVid = .init()

    lazy var backView: BackView = .init()

    lazy var detailsButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.EditCard.Action.updateDetails)
        return button
    }(SportivinieKartiCommonB(style: .default))

    lazy var noSalesView: SportivinieKartiCMessageV = { view in
        view.postavitZagolovok(L10n.PricingReport.Details.noSales)
        return view
    }(SportivinieKartiCMessageV())

    lazy var salesTableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        return tableView
    }(UITableView())

    lazy var tableHeaderView: UIView = sdelatHeader()

    private var noSalesViewTopConstraint: Constraint?

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    override func layoutSubviews() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        super.layoutSubviews()
        if UIDevice.isIpad { detailsView.stackViewIpad.sdelatGranici()
        } else {
            detailsView.priceContainer.sdelatGranici()

        }

    }

    func ebratVidProdazh() {
        salesTableView.addSubview(noSalesView)
        noSalesView.snp.makeConstraints {
            noSalesViewTopConstraint = $0.top.equalTo(salesTableView.safeAreaLayoutGuide).constraint
            $0.horizontalEdges.equalTo(salesTableView.frameLayoutGuide).inset(UIDevice.isIpad ? 80:20)
        }
    }

    func obnovitVidSubviews() {
        let inset = tableHeaderView.frame.height + 30
        noSalesViewTopConstraint?.update(inset: inset)
    }
}

private extension SportivinieKartiCenaOcenkaVide {
    func postavitVidunicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        backgroundColor = .clear
        backView.postavitVid(in: self)

        backView.addSubview(detailsView)
        detailsView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 50:40)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
//            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 400:0)
        }

        let recentSalesLabel = UILabel()
        recentSalesLabel.text = L10n.PricingReport.Details.recentSales
        recentSalesLabel.textColor = .labelColor
        recentSalesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 26:20)
        recentSalesLabel.setVisotaLabla(UIDevice.isIpad ? 30:22)
        recentSalesLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        backView.addSubview(recentSalesLabel)
        recentSalesLabel.snp.makeConstraints {
            $0.top.equalTo(detailsView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        backView.addSubview(salesTableView)
        salesTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(recentSalesLabel.snp.bottom).offset(UIDevice.isIpad ? 15:5)
        }
        addSubview(detailsButton)
        detailsButton.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ? 80:56)
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            make.bottom.equalToSuperview().inset(UIDevice.isIpad ? 70:50)
        }

    }

    func sdelatHeader() -> UIView {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let headerView = UIView()

        return headerView
    }
}
