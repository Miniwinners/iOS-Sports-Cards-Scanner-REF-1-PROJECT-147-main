import UIKit
import SnapKit

extension CurrentValueDetailsView {
    final class CategoryValueView: UIView {
        lazy var colorView: UIView = .init()
        lazy var categoryLabel: UILabel = .init()
        lazy var valueLabel: UILabel = .init()

        convenience init(category: CardCategory, value: Double) {
            self.init(frame: .zero)
            setupSubviews_unique()
            setCategory(category)
            setCategoryValue(value)
        }
    }
}

private extension CurrentValueDetailsView.CategoryValueView {
    func setCategory(_ category: CardCategory) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        colorView.backgroundColor = category.color
        categoryLabel.text = category.title
    }

    func setCategoryValue(_ value: Double) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        valueLabel.text = value.formattedAsPrice
    }

    func setupSubviews_unique() {
        categoryLabel.textColor = .labelColor
        categoryLabel.font = .font(.interMedium, size: 18)
        colorView.layer.cornerRadius = 7
        colorView.layer.masksToBounds = false
        colorView.clipsToBounds = true
        valueLabel.textColor = .labelColor
        valueLabel.font = .font(.interMedium, size: 18)
        valueLabel.lineBreakMode = .byTruncatingMiddle
        valueLabel.textAlignment = .right

        snp.makeConstraints {
            $0.height.equalTo(22)
        }

        addSubviews(colorView, categoryLabel, valueLabel)
        colorView.snp.makeConstraints {
            $0.size.equalTo(14)
            $0.leading.centerY.equalToSuperview()
        }
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        valueLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
            $0.trailing.centerY.equalToSuperview()
        }
    }
}
