import UIKit
import SnapKit

final class DashboardView: UIView {

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        return scrollView
    }(BaseScrollView())

    lazy var contentView: UIView = { view in
        return view
    }(UIView())

    lazy var noCardView: DashboardNoCardView = .init()
    lazy var cardsView: DashboardCardsView = .init()

    lazy var scanCardButton: CommonButton = { button in
        button.setButtonTitle(L10n.Dashboard.Action.scanCard)
        button.setImage(Images.scan.image, for: .normal)
        button.configuration?.imagePadding =  20
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func showNoCardView() {
        cardsView.removeFromSuperview()
        self.backgroundColor = .skyBlue
        contentView.addSubview(noCardView)
        noCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func showCardsView() {
        noCardView.removeFromSuperview()
        self.backgroundColor = .white
        contentView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateCurrentValueView(currentValue: Double, categoryValues: [(CardCategory, Double)]) {
        let currentValueView = cardsView.currentValueView
        currentValueView.setCurrentCardsValue(currentValue)
        currentValueView.setCategoryValues(categoryValues)
    }

    func updateHighestValueView(first highestValuedCard: CardRepresentable?, second highestTwo: CardRepresentable?, third highestThree: CardRepresentable?) {
        let highestValueView = cardsView.highestValueView
        highestValueView.isHidden = highestValuedCard.isNil
        if let card = highestValuedCard {
            highestValueView.setCard(card, highestTwo ?? card, highestThree ?? card)
        }
    }

    func updateRecentlyAddedView(with cards: [CardRepresentable]) {
        let recentlyAddedView = cardsView.recentlyAddedView
        recentlyAddedView.setRecentlyAddedCards(cards)
    }
}

private extension DashboardView {
    func setupSubviews_unique() {
        backgroundColor = .skyBlue

        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        addSubview(scanCardButton)
        scanCardButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 80 : 54)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ?  70 : 30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
        }
    }
}
