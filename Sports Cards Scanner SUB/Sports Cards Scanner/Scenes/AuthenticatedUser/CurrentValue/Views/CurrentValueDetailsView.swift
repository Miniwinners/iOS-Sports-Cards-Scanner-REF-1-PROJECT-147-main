import UIKit
import SnapKit

final class CurrentValueDetailsView: UIView {

    lazy var currentValueLabel: UILabel = { label in
        label.font = .font(.interBold, size: 32)
        label.textColor = .greenColor
        label.lineBreakMode = .byTruncatingMiddle
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var containerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var categoryValueLabel: UILabel = { label in
        label.text = L10n.CurrentValue.valueByCategory
        label.font = .font(.interMedium, size: 20)
        label.textColor = .labelColor
        label.setLineHeight(22)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

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
            let path = UIBezierPath(arcCenter: .init(x: 120, y: 120), radius: 88, startAngle: startAngle, endAngle: endAngle, clockwise: true)
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
        addSubviews(currentValueLabel, containerView)
        currentValueLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        containerView.snp.makeConstraints {
            $0.top.equalTo(currentValueLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }

        containerView.addSubviews(categoryValueLabel, diagramView, categoryValuesView)
        categoryValueLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        diagramView.snp.makeConstraints {
            $0.top.equalTo(categoryValueLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(240)
        }
        categoryValuesView.snp.makeConstraints {
            $0.top.equalTo(diagramView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(44)
        }
    }
}
