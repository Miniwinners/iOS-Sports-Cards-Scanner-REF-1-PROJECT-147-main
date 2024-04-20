import UIKit
import SnapKit

class SelectableTableViewCell: UITableViewCell {

    lazy var containerView: UIView = .init()

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuLight300, size: 16)
        return label
    }(UILabel())

    lazy var rightImageView: UIImageView = .init()

    private(set) var topConstraint: Constraint!
    private(set) var bottomConstraint: Constraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelectableTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        backgroundView = createBackgroundView()
        selectedBackgroundView = createHighlightedView()

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(22)
            topConstraint = $0.top.equalToSuperview().inset(20).constraint
            bottomConstraint = $0.bottom.equalToSuperview().inset(20).constraint
        }

        containerView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(9)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel)
        }

    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 16
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    func createHighlightedView() -> UIView {
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.layer.cornerRadius = 16

        highlightedView.backgroundColor = .highlightColor2
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return highlightedContainerView
    }
}
// MARK: - COLLECTIONVIEWCELL
class SelectableCollectionViewCell: UICollectionViewCell {
    lazy var containerView: UIView = .init()

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: 15)
        label.textAlignment = .center

        return label
    }(UILabel())

    lazy var rightImageView: UIImageView = .init()

    private(set) var topConstraint: Constraint!
    private(set) var bottomConstraint: Constraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelectableCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .skyBlue
        layer.cornerRadius = 16
        contentView.layer.cornerRadius = 16

        containerView.layer.cornerRadius = 16
        backgroundView = createBackgroundView()
        selectedBackgroundView = createHighlightedView()

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }

        containerView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints {
            $0.size.equalTo(31)
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .skyBlue
        backgroundView.layer.cornerRadius = 16
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    func createHighlightedView() -> UIView {
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.layer.cornerRadius = 16

        highlightedView.backgroundColor = .highlightColor2
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return highlightedContainerView
    }
}
