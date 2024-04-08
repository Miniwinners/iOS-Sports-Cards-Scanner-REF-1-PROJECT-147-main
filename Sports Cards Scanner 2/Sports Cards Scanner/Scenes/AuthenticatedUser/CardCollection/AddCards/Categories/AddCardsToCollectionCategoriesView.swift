import UIKit
import SnapKit

final class AddCardsToCollectionCategoriesView: UIView {

    private var categoriesTableHeightConstraint: Constraint!

    lazy var categoriesContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 14)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        return tableView
    }(UITableView())

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.cancel)
        return button
    }(CommonButton(style: .cancel))

    lazy var doneButton: CommonButton = { button in
        button.setButtonTitle(L10n.Common.done)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setSelectedCards(number: Int) {
        switch number {
        case 1:
            selectedCardsLabel.text = L10n.AddCards.oneCardSelected
        default:
            selectedCardsLabel.text = L10n.AddCards.numberOfCardsSelected(number)
        }
        selectedCardsLabel.setLineHeight(22)
    }

    func updateCategories(count: Int) {
        if count == 0 {
            hideCategories()
        } else {
            showCategories()
        }

        let tableViewHeight: CGFloat = CGFloat(count) * CGFloat(36) + 26
        categoriesTableHeightConstraint.update(offset: tableViewHeight)
    }
}

private extension AddCardsToCollectionCategoriesView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        setupCardsView()
        setupButtons_unique()
    }

    func setupCardsView() {
        let allCardsLabel = UILabel()
        allCardsLabel.font = .font(.interMedium, size: 20)
        allCardsLabel.textColor = .labelColor
        allCardsLabel.text = L10n.AddCards.allCards
        allCardsLabel.setLineHeight(24)
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        categoriesContainerView.addSubviews(allCardsLabel, selectedCardsLabel)
        allCardsLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(.high)
        }
        selectedCardsLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
        }

        addSubview(categoriesContainerView)
        categoriesContainerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(14)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
    }

    func setupButtons_unique() {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }
    }

    func showCategories() {
        guard categoriesTableView.superview == nil else { return }

        categoriesContainerView.addSubviews(underlineView, categoriesTableView)
        underlineView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            categoriesTableHeightConstraint = $0.height.equalTo(0).constraint
        }
    }

    func hideCategories() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        underlineView.removeFromSuperview()
        categoriesTableView.removeFromSuperview()
    }
}
