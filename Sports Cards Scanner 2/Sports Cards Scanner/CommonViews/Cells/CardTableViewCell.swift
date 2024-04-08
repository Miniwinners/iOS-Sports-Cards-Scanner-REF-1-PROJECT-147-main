import UIKit
import SnapKit

final class CardTableViewCell: UITableViewCell {

    private static let containerHeight: CGFloat = 146

    lazy var cardView: CardView = .init()

    lazy var separatorView: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.prepareForReuse()
        cardView.resetView()
    }

    func setupCard(_ card: CardRepresentable) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardView.setCard(card)
    }

    func setChecked(_ checked: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardView.setChecked(checked)
    }

    func setSelectable(_ selectable: Bool) {
        selectionStyle = selectable ? .default : .none
        backgroundView?.subviews.first?.backgroundColor = selectable ? .white : .secondaryColor
    }

    func setCardsNumber(_ number: Int?) {
        cardView.setCardsNumber(number)
    }

    func setCellPosition(_ cellPosition: CellPosition) {
        separatorView.isHidden = cellPosition.containsPosition(.atBottomPosition)
    }
}

private extension CardTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundView = createBackgroundView()
        selectedBackgroundView = createHighlightedView()

        let containerView = UIView()
        containerView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(.high)
        }

        let stackView = UIStackView(arrangedSubviews: [containerView, separatorView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        separatorView.snp.makeConstraints {
            $0.height.equalTo(16)
        }
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.cornerRadius = 12
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(CardTableViewCell.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    func createHighlightedView() -> UIView {
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        highlightedView.cornerRadius = 12
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(CardTableViewCell.containerHeight + 1)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return highlightedContainerView
    }
}
