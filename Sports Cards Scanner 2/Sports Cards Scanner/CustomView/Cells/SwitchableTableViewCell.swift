import UIKit
import SnapKit

class SwitchableTableViewCell: UITableViewCell {

    var switchValueDidChange: ((Bool) -> Void)?

    lazy var containerView: UIView = .init()

    lazy var titleLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.interMedium, size: 18)
        return label
    }(UILabel())

    lazy var switchView: UISwitch = .init()

    lazy var separatorView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    private(set) var topConstraint: Constraint!
    private(set) var bottomConstraint: Constraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
        setupActions_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SwitchableTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        selectionStyle = .none

        backgroundView = createBackgroundView()

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            topConstraint = $0.top.equalToSuperview().inset(20).constraint
            bottomConstraint = $0.bottom.equalToSuperview().inset(20).constraint
        }

        containerView.addSubview(switchView)
        switchView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel)
        }

    }

    func setupActions_unique() {
        switchView.addTarget(self, action: #selector(switchDidTapped(_:)), for: .valueChanged)
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    // MARK: - Actions

    @objc func switchDidTapped(_ sender: UISwitch) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        switchValueDidChange?(sender.isOn)
    }
}

class SwitchableCollectionViewCell: UICollectionViewCell {

    var switchValueDidChange: ((Bool) -> Void)?

    lazy var containerView: UIView = .init()

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ?24: 15)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var switchView: UISwitch = .init()

    private(set) var topConstraint: Constraint!
    private(set) var bottomConstraint: Constraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()
        setupActions_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SwitchableCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .skyBlue
        layer.cornerRadius = UIDevice.isIpad ? 24:16

        containerView.layer.cornerRadius = UIDevice.isIpad ? 24:16
        contentView.layer.cornerRadius = UIDevice.isIpad ? 24:16

        backgroundView = createBackgroundView()

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }

        containerView.addSubview(switchView)
        switchView.snp.updateConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 52:32)
            $0.width.equalTo(UIDevice.isIpad ? 81:48)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
            $0.horizontalEdges.equalToSuperview()
        }

    }

    func setupActions_unique() {
        switchView.addTarget(self, action: #selector(switchDidTapped(_:)), for: .valueChanged)
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .skyBlue
        backgroundView.layer.cornerRadius = UIDevice.isIpad ? 24:16
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().priority(.high)
        }

        return backgroundContainerView
    }

    // MARK: - Actions

    @objc func switchDidTapped(_ sender: UISwitch) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        switchValueDidChange?(sender.isOn)
    }

}
