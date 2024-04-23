import UIKit
import SnapKit

final class CurrentValueDetailsView: UIView {

    lazy var titleLabel: TitleLabel = .init()

    lazy var currentValueLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: 40)
        label.textColor = .greenColor
        label.lineBreakMode = .byTruncatingMiddle
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var categoryValuesTable: UITableView = { table in
        table.register(CurrentValuesDetailsTableViewCell.self, forCellReuseIdentifier: CurrentValuesDetailsTableViewCell.cellIdentifier)
        table.separatorStyle = .none
        table.isUserInteractionEnabled = false
        return table
    }(UITableView())

    lazy var diagramView: UIView = .init()

    lazy var categoryValuesView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }(UIStackView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCategoriesValues(
        current currentValue: Double,
        categories categoryValues: [(CardCategory, Double)]
    ) {
        currentValueLabel.text = currentValue.formattedAsPrice

        categoryValues
            .map { CategoryValueView(category: $0.0, value: $0.1) }
            .forEach { categoryValuesView.addArrangedSubview($0) }

        var startAngle: CGFloat = -.pi / 2
        categoryValues.forEach { category, value in
            let diffAngle: CGFloat = value / currentValue * .pi * 2
            let endAngle = startAngle + diffAngle
            let path = UIBezierPath(arcCenter: .init(x: 120, y: 120), radius: 120, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            startAngle += diffAngle
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.lineWidth = 21
            layer.strokeColor = category.color.cgColor
            layer.fillColor = UIColor.clear.cgColor
            diagramView.layer.addSublayer(layer)
        }
    }

}

private extension CurrentValueDetailsView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        titleLabel.setupLabel(in: self)
        categoryValuesTable.backgroundColor = .skyBlue
        categoryValuesTable.layer.cornerRadius = 16

        addSubviews(currentValueLabel, diagramView, categoryValuesTable)

        diagramView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(240)
        }

        currentValueLabel.snp.makeConstraints {
            $0.center.equalTo(diagramView)
        }

        categoryValuesTable.snp.makeConstraints {
            $0.top.equalTo(diagramView.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(300)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
