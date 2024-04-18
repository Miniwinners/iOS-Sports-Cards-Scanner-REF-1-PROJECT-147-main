import UIKit
import SnapKit

final class DashboardCardsView: UIView {

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }(UIStackView(arrangedSubviews: [currentValueView, highestValueView, recentlyAddedView]))

    lazy var currentValueView: CurrentCardsValueView = .init()
    lazy var highestValueView: HighestCardsValueView = .init()
    lazy var recentlyAddedView: RecentlyAddedCardsView = .init()

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .white
        setupSubviews_unique()
    }

}

private extension DashboardCardsView {
    func setupSubviews_unique() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(84)
        }
        highestValueView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(400)
        }
    }
}
