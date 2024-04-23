import UIKit
import SnapKit

final class PortfolioView: UIView {

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.contentInset.bottom = 84
        return scrollView
    }(BaseScrollView())

    lazy var contentView: UIView = { view in
        return view
    }(UIView())

    lazy var noCardView: PortfolioNoCardView = .init()
    lazy var cardsView: PortfolioCardsView = .init()

    lazy var scanCardButton: CommonButton = { button in
        button.setButtonTitle(L10n.Dashboard.Action.scanCard)
        button.setImage(Images.scan.image, for: .normal)
        button.configuration?.imagePadding = 20
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func showNoCardView() {
        cardsView.removeFromSuperview()

        contentView.addSubview(noCardView)
        noCardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func showCardsView() {
        noCardView.removeFromSuperview()

        contentView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func updateCardCollection(_ collection: CardCollectible?) {
        cardsView.collectionView.setCardSet(collection)
    }

    func updateCardDeck(_ deck: CardCollectible?) {
        cardsView.deckView.setCardSet(deck)
    }

    func updateCardsTotalValue(_ cardsValue: Double) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardsView.infoView.setCardsValue(cardsValue)
    }

    func updateCardsNumber(_ number: Int, maxNumber: Int) {
        cardsView.infoView.setCardsNumber(number, maxNumber: maxNumber)
    }

    func updateCategories(number: Int) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        cardsView.updateCategories(number: number)
    }
}

private extension PortfolioView {
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
            $0.height.equalTo(54)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
