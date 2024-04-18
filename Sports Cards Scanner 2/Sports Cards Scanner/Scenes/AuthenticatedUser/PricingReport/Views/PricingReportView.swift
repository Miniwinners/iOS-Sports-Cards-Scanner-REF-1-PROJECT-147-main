import UIKit
import SnapKit

final class PricingReportView: UIView {

    lazy var detailsView: PricingReportDetailsView = .init()

    lazy var backView: UIView = { view in
        view.setupBackView()
        return view
    }(UIView())

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
            $0.horizontalEdges.equalTo(salesTableView.frameLayoutGuide).inset(20)
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
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        backView.addSubview(salesTableView)
        salesTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }

        salesTableView.tableHeaderView = tableHeaderView
    }

    func setupHeaderView() -> UIView {
        let headerView = UIView()

        headerView.addSubview(detailsView)
        detailsView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        let recentSalesLabel = UILabel()
        recentSalesLabel.text = L10n.PricingReport.Details.recentSales
        recentSalesLabel.textColor = .labelColor
        recentSalesLabel.font = .font(.interMedium, size: 20)
        recentSalesLabel.setLineHeight(22)
        recentSalesLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        headerView.addSubview(recentSalesLabel)
        recentSalesLabel.snp.makeConstraints {
            $0.top.equalTo(detailsView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(12)
        }

        return headerView
    }
}
