import UIKit
import SnapKit

final class RemoveCardsView: UIView {

    private var cardsHeightConstraint: Constraint!

    lazy var nameLabel: UILabel = { label in
        label.font = .font(.interBold, size: 24)
        label.textColor = .labelColor
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 14)
        label.textColor = .labelColor
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }(UILabel())

    lazy var cardsCollectionView: UICollectionView = { collectionView in
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = false
        return collectionView
    }(BaseCollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))

    lazy var doneButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(CommonButton(style: .default))

    lazy var noCardsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.CardCollection.noCards)
        return view
    }(CommonMessageView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setCollectionName(_ name: String?) {
        nameLabel.text = name
        nameLabel.setLineHeight(28)
    }

    func setCards(count: Int) {
        switch count {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(count)
        }
        cardsNumberLabel.setLineHeight(22)
    }

    func updateCards(count: Int, animated: Bool) {
        let layout = cardsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let cardsWidth = cardsCollectionView.bounds.width
        let horizontalSpacing: CGFloat = (layout?.sectionInset.left ?? 0) + (layout?.sectionInset.right ?? 0)
        let verticalSpacing: CGFloat = (layout?.sectionInset.top ?? 0) + (layout?.sectionInset.bottom ?? 0)
        let itemsInRow: CGFloat = 3
        let interitemSpacing: CGFloat = layout?.minimumInteritemSpacing ?? 0
        let itemWidth = (cardsWidth - horizontalSpacing - (itemsInRow - 1) * interitemSpacing) / itemsInRow
        let photoWidth = itemWidth - 6
        let photoHeight = photoWidth * 1.388
        let itemHeight = photoHeight + 6
        let rowsCount = (CGFloat(count) / itemsInRow).rounded(.up)
        let cardsHeight = itemHeight * rowsCount + interitemSpacing * (rowsCount - 1) + verticalSpacing
        cardsHeightConstraint.update(offset: max(0, cardsHeight))

        nameLabel.snp.remakeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(cardsHeight <= 0 ? .required : .low)
        }

        if animated {
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
        }
    }

    func setNoCardsView(visible: Bool) {
        noCardsView.isHidden = !visible
    }

}

private extension RemoveCardsView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.cornerRadius = 12
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        containerView.addSubviews(nameLabel, cardsNumberLabel, cardsCollectionView)
        nameLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(.low)
        }
        cardsNumberLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
        }
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(18)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16).priority(.high)
            cardsHeightConstraint = $0.height.equalTo(0).priority(.medium).constraint
        }

        addSubview(noCardsView)
        noCardsView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(containerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }
    }

    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = .init(top: 2, left: 16, bottom: 0, right: 10)
        return layout
    }
}
