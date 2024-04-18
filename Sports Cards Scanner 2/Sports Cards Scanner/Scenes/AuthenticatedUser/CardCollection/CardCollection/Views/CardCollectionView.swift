import UIKit
import SnapKit

final class CardCollectionView: UIView {

    lazy var noCardsView: CardCollectionNoCardsView = .init()
    lazy var cardsView: CardCollectionCardsView = .init()

    lazy var backView: UIView = { view in
        view.setupBackView()
        return view
    }(UIView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func showNoCards() {
        cardsView.removeFromSuperview()

        backView.addSubview(noCardsView)
        noCardsView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }

    func showCards() {
        noCardsView.removeFromSuperview()

        backView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.horizontalEdges.bottom.equalToSuperview()

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
        addSubview(backView)
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
