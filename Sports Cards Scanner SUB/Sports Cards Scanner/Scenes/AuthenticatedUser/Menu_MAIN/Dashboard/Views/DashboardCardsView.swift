import UIKit
import SnapKit

final class DashboardCardsView: UIView {

    lazy var stackView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.spacing = UIDevice.isIpad ? 20 : 10
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
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 50 : 40)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 140 : 90)
        }
        highestValueView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(UIDevice.isIpad ? 530 : 400)
        }
    }
}
