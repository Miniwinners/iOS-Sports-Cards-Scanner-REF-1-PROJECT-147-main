import UIKit
import SnapKit

final class CardCollectionView: UIView {

    lazy var noCardsView: CardCollectionNoCardsView = .init()
    lazy var cardsView: CardCollectionCardsView = .init()

    lazy var backView: BackView = .init()

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func showNoCards() {
        cardsView.removeFromSuperview()

        backView.addSubview(noCardsView)
        noCardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func showCards() {
        noCardsView.removeFromSuperview()

        backView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension CardCollectionView {
    func setupSubviews_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        backgroundColor = .clear
        backView.setupView(in: self)
    }
}
