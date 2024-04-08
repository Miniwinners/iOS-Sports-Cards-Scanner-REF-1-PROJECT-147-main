import UIKit
import SnapKit

final class CurrentValueDetailsViewController: UIViewController {

    private let cardsManager: UserCardsManager

    weak var delegate: CurrentValueDetailsViewControllerDelegate?

    // MARK: - Subviews

    lazy var scrollView: UIScrollView = { scrollView in
        scrollView.alwaysBounceVertical = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentInset.bottom = 20
        return scrollView
    }(BaseScrollView())

    lazy var currentValueDetailsView: CurrentValueDetailsView = .init()

    init(cardsManager: UserCardsManager = .shared) {
        self.cardsManager = cardsManager
        super.init(nibName: nil, bundle: nil)
        title = L10n.CurrentValue.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        setupViews_unique()
    }

}

private extension CurrentValueDetailsViewController {
    var categoryValues: [(CardCategory, Double)] {
        CardCategory.allCases
            .map { ($0, cardsManager.cardsValue(of: $0)) }
            .filter { $0.1 != 0 }
    }

    func setupViews_unique() {
        view.backgroundColor = .backColor

        navigationItem.rightBarButtonItem = .init(
            image: Images.close.image,
            style: .plain,
            target: self,
            action: #selector(closeTapped_unique)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        scrollView.addSubview(currentValueDetailsView)
        currentValueDetailsView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.height.equalTo(scrollView.frameLayoutGuide).priority(.high)
        }

        currentValueDetailsView.setCategoriesValues(current: cardsManager.currentCardsValue, categories: categoryValues)
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.currentValueDetailsViewControllerCloseTapped(self)
    }
}
