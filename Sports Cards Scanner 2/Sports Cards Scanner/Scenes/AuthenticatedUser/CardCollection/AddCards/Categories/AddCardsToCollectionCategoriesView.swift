import UIKit
import SnapKit

final class AddCardsToCollectionCategoriesView: UIView {

    private var categoriesTableHeightConstraint: Constraint!

    lazy var backView: BackView = .init()

    lazy var titleLabel: TitleLabel = .init()

    lazy var categoriesContainerView: UIView = { view in
        view.backgroundColor = .white
//        view.cornerRadius =  12
        return view
    }(UIView())

    lazy var selectedCardsLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20 : 14)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }(UILabel())

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.sectionHeaderTopPadding = 0
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
    }

    func updateCategories(count: Int) {
        if count == 0 {
            hideCategories()
        } else {
            showCategories()
        }

//        let tableViewHeight: CGFloat = CGFloat(count) * CGFloat(36) + 26
//        categoriesTableHeightConstraint.update(offset: tableViewHeight)
    }
}

private extension AddCardsToCollectionCategoriesView {
    func setupSubviews_unique() {
        backgroundColor = .clear

        setupCardsView()
        setupButtons_unique()
    }

    func setupCardsView() {
        backView.setupView(in: self)

        titleLabel.setupLabel(in: backView)

        let allCardsLabel = UILabel()
        allCardsLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        allCardsLabel.textColor = .black
        allCardsLabel.text = L10n.AddCards.allCards
        allCardsLabel.setContentHuggingPriority(.required, for: .vertical)
        allCardsLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        categoriesContainerView.addSubviews(allCardsLabel, selectedCardsLabel)

        allCardsLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(10) // Добавляем отступ снизу для определения высоты контейнера
        }

        selectedCardsLabel.snp.makeConstraints {
            $0.centerY.equalTo(allCardsLabel)
            $0.right.equalToSuperview().inset(16) // Добавляем отступ справа
            $0.height.equalTo(30)
            $0.left.equalTo(allCardsLabel.snp.right).offset(15)
        }

        backView.addSubview(categoriesContainerView)
        categoriesContainerView.backgroundColor = .clear
        categoriesContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ? 60:50)
        }

    }

    func setupButtons_unique() {
        let stackView = UIStackView(arrangedSubviews: [cancelButton, doneButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20

        backView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
            $0.height.equalTo(UIDevice.isIpad ? 172:128)
        }
    }

    func showCategories() {
        guard categoriesTableView.superview == nil else { return }

        backView.addSubviews(categoriesTableView)
        categoriesTableView.snp.makeConstraints {
            $0.top.equalTo(categoriesContainerView.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.bottom.equalToSuperview().inset(16)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80: 16)
        }
    }

    func hideCategories() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        categoriesTableView.removeFromSuperview()
    }
}
