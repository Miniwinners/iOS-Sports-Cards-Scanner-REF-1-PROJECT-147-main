import UIKit
import SnapKit

final class RemoveCardsView: UIView {

    private var cardsHeightConstraint: Constraint!

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var cardsNumberLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)
        label.textColor = .black
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
        titleLabel.text = name
//        titleLabel.setLineHeight(UIDevice.isIpad ? 32:28)
    }

    func setCards(count: Int) {
        switch count {
        case 1:
            cardsNumberLabel.text = L10n.Portfolio.oneCard
        default:
            cardsNumberLabel.text = L10n.Portfolio.numberOfCards(count)
        }
        cardsNumberLabel.setLineHeight(UIDevice.isIpad ? 28:22)
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
        backgroundColor = .clear
        backView.setupView(in: self)
        titleLabel.setupLabel(in: backView)
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.cornerRadius = 12
        backView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        containerView.addSubviews(cardsNumberLabel, cardsCollectionView)

        cardsNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 60: 30)
            $0.trailing.equalToSuperview().inset(UIDevice.isIpad ? 80:16)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
        cardsCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30:18)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16).priority(.high)
            cardsHeightConstraint = $0.height.equalTo(0).priority(.medium).constraint
        }

        backView.addSubview(noCardsView)
        noCardsView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        backView.addSubview(doneButton)
        doneButton.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(containerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
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
