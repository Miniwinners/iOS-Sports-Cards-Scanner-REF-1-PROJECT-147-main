import UIKit
import SnapKit

final class PromptViewController: UIViewController {

    private let promptTitle: String
    private let promptDescription: String
    weak var delegate: PromptViewControllerDelegate?

    // MARK: - Subviews

    private lazy var labelsContainerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var titleLabel: UILabel = { label in
        label.text = promptTitle
        label.font = .font(.interBold, size: 24)
        label.textColor = .black
        label.setLineHeight(28)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var descriptionLabel: UILabel = { label in
        label.text = promptDescription
        label.font = .font(.interRegular, size: 14)
        label.textColor = .labelColor4
        label.setLineHeight(22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Prompt.Action.cancel)
        return button
    }(CommonButton(style: .cancel))

    lazy var confirmButton: CommonButton = { button in
        return button
    }(CommonButton(style: .default))

    init(title: String = L10n.Prompt.title, description: String) {
        self.promptTitle = title
        self.promptDescription = description
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredContentSize: CGSize {
        get {
            view.layoutIfNeeded()
            return .init(width: view.bounds.width, height: 394)
        }
        set {
            super.preferredContentSize = newValue
        }
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
        setupActions_unique()
    }

}

private extension PromptViewController {
    func setupViews_unique() {
        view.backgroundColor = .backColor

        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 20

        labelsContainerView.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(16).priority(.high)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonsStackView.axis = .horizontal
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 20

        view.addSubviews(labelsContainerView, buttonsStackView)
        labelsContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(140)
        }
        buttonsStackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(labelsContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(54)
        }
    }

    func setupActions_unique() {
        cancelButton.addTarget(self, action: #selector(cancelTapped_unique(_:)), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmTapped_unique(_:)), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func cancelTapped_unique(_ sender: CommonButton) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        delegate?.promptViewControllerCancelTapped(self)
    }

    @objc func confirmTapped_unique(_ sender: CommonButton) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        delegate?.promptViewControllerConfirmTapped(self)
    }
}
