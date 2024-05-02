import UIKit
import SnapKit

final class PricingReportView: UIView {

    lazy var detailsView: PricingReportDetailsView = .init()

    lazy var backView: BackView = .init()

    lazy var noSalesView: CommonMessageView = { view in
        view.setMessageTitle(L10n.PricingReport.Details.noSales)
        return view
    }(CommonMessageView())

    lazy var salesTableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        return tableView
    }(UITableView())

    lazy var tableHeaderView: UIView = setupHeaderView()

    private var noSalesViewTopConstraint: Constraint?

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func showNoSales() {
        salesTableView.addSubview(noSalesView)
        noSalesView.snp.makeConstraints {
            noSalesViewTopConstraint = $0.top.equalTo(salesTableView.safeAreaLayoutGuide).constraint
            $0.horizontalEdges.equalTo(salesTableView.frameLayoutGuide).inset(UIDevice.isIpad ? 80:20)
        }
    }

    func updateSubviewsPositions() {
        let inset = tableHeaderView.frame.height + 30
        noSalesViewTopConstraint?.update(inset: inset)
    }
}

private extension PricingReportView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        backView.setupView(in: self)

        backView.addSubview(detailsView)
        detailsView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        let recentSalesLabel = UILabel()
        recentSalesLabel.text = L10n.PricingReport.Details.recentSales
        recentSalesLabel.textColor = .labelColor
        recentSalesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 26:20)
        recentSalesLabel.setLineHeight(22)
        recentSalesLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        backView.addSubview(recentSalesLabel)
        recentSalesLabel.snp.makeConstraints {
            $0.top.equalTo(detailsView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        let blockedLabel = UILabel()
        blockedLabel.text = "Blocked"
        blockedLabel.textColor = .labelColor2
        blockedLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        blockedLabel.setLineHeight(18)
        backView.addSubview(blockedLabel)
        blockedLabel.snp.makeConstraints {
            $0.top.equalTo(recentSalesLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
//            $0.bottom.equalToSuperview().inset(12)
        }

        backView.addSubview(salesTableView)
        salesTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(blockedLabel.snp.bottom).offset(20)
        }
//                salesTableView.isHidden = false

//        salesTableView.tableHeaderView = tableHeaderView
    }

    func setupHeaderView() -> UIView {
        let headerView = UIView()

//        headerView.addSubview(detailsView)
//        detailsView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
//        }
//
//        let recentSalesLabel = UILabel()
//        recentSalesLabel.text = L10n.PricingReport.Details.recentSales
//        recentSalesLabel.textColor = .labelColor
//        recentSalesLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 26:20)
//        recentSalesLabel.setLineHeight(22)
//        recentSalesLabel.setContentCompressionResistancePriority(.required, for: .vertical)
//        headerView.addSubview(recentSalesLabel)
//        recentSalesLabel.snp.makeConstraints {
//            $0.top.equalTo(detailsView.snp.bottom).offset(20)
//            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
//        }
//
//        let blockedLabel = UILabel()
//        blockedLabel.text = "Blocked"
//        blockedLabel.textColor = .labelColor2
//        blockedLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
//        blockedLabel.setLineHeight(18)
//        headerView.addSubview(blockedLabel)
//        blockedLabel.snp.makeConstraints {
//            $0.top.equalTo(recentSalesLabel.snp.bottom).offset(5)
//            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
//            $0.bottom.equalToSuperview().inset(12)
//        }

        return headerView
    }
}
