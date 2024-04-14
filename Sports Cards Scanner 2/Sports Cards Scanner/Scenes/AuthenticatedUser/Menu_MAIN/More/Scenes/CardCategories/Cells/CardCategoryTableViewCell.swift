import UIKit
import SnapKit

final class CardCategoryTableViewCell: UITableViewCell {

    lazy var containerView: UIView = .init()

    lazy var reorderImageView: UIImageView = { image in
        return image
    }(UIImageView())

    lazy var titleLabel: UILabel = { label in
        label.textColor = .logInLabel
        label.font = .font(.ubuntuMedium500, size: 16)
        return label
    }(UILabel())

    lazy var switchView: UISwitch = .init()

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    private var onCategoryDidSwitch: BoolClosure?

    private(set) var cellPosition: CellPosition?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCategoryCell(with categoryModel: CardCategoryModel, onCategoryDidSwitch: @escaping BoolClosure) {
        titleLabel.text = categoryModel.category.title
        switchView.setOn(categoryModel.isEnabled, animated: false)
        reorderImageView.image = categoryModel.category.image
        self.onCategoryDidSwitch = onCategoryDidSwitch
    }

    func updateCellPosition(_ position: CellPosition) {
        if cellPosition == position { return }
        cellPosition = position

    }

    func setSwitchOff(available: Bool) {
        guard switchView.isOn else { return }

        switchView.isEnabled = available
    }
}

private extension CardCategoryTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        containerView.backgroundColor = .skyBlue
        containerView.layer.cornerRadius = 16
        selectionStyle = .none

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        containerView.addSubview(reorderImageView)
        reorderImageView.snp.makeConstraints {
            $0.size.equalTo(22)
            $0.leading.equalToSuperview().inset(16)
            topConstraint = $0.top.equalToSuperview().inset(17).constraint
            bottomConstraint = $0.bottom.equalToSuperview().inset(17).priority(.high).constraint
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(reorderImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(reorderImageView)
        }

        containerView.addSubview(switchView)
        switchView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(reorderImageView)
            $0.trailing.equalToSuperview().inset(16)
        }

        backgroundView = createBackgroundView()

        switchView.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    @objc func switchStateChanged(_ sender: UISwitch) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        onCategoryDidSwitch?(sender.isOn)
    }
}
