import UIKit
import SnapKit

final class CardTableViewCell: UITableViewCell {

    private static let containerHeight: CGFloat = UIDevice.isIpad ? 232 : 157

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
        backgroundView?.subviews.first?.backgroundColor = selectable ? .skyBlue : .highlightColor2
    }

    func setCardsNumber(_ number: Int?) {
        cardView.setCardsNumber(number)
    }

}

private extension CardTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundView = createBackgroundView()
        selectedBackgroundView = createHighlightedView()
        let containerView = UIView()
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        containerView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(CardTableViewCell.containerHeight)
        }

        cardView.cardImageView.snp.remakeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(UIDevice.isIpad ? 143 : 96)
        }
        cardView.titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            make.left.equalTo(cardView.cardImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(5)
        }

        cardView.subtitleLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(cardView.titleLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5).priority(.medium)
            make.left.equalTo(cardView.cardImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(5)
            make.height.equalTo(UIDevice.isIpad ? 30:20)
        }

        cardView.pricesLabel.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(UIDevice.isIpad ? 50:30)
            make.height.equalTo(UIDevice.isIpad ? 30:20)
            make.left.equalTo(cardView.cardImageView.snp.right).offset(20)
        }

    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .skyBlue
        backgroundView.cornerRadius = UIDevice.isIpad ? 20:12
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(CardTableViewCell.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return backgroundContainerView
    }

    func createHighlightedView() -> UIView {
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        highlightedView.cornerRadius = UIDevice.isIpad ? 20:12
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(CardTableViewCell.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return highlightedContainerView
    }
}
