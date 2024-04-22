import UIKit
import SnapKit

class CurrentValuesDetailsTableViewCell: UITableViewCell {

    static let cellIdentifier = "CurrentValuesDetailsTableViewCell"

    static let cellHeight: CGFloat = 36

    lazy var categoryLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.ubuntuRegular400, size: 16)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var priceLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuBold700, size: 16)
        label.lineBreakMode = .byTruncatingMiddle
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var colorView: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(category: CardCategory, value: Double) {
        colorView.backgroundColor = category.color
        categoryLabel.text = category.title
        priceLabel.text = value.formattedAsPrice
    }

}

private extension CurrentValuesDetailsTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        colorView.layer.cornerRadius = 7
        colorView.layer.masksToBounds = false
        colorView.clipsToBounds = true

        let containerView = UIView()
        containerView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.height.equalTo(Self.cellHeight)
            $0.edges.equalToSuperview()
        }

        containerView.addSubview(colorView)
        colorView.snp.makeConstraints {
            $0.size.equalTo(14)
            $0.top.equalToSuperview().offset(22)
            $0.leading.equalToSuperview().inset(20)
        }

        containerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalTo(colorView.snp.trailing).offset(10)
        }

        containerView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.leading.greaterThanOrEqualTo(categoryLabel.snp.trailing).offset(8)
        }

    }
}
