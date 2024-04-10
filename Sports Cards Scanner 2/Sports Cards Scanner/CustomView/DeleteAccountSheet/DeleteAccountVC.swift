import UIKit
import SnapKit

final class DeleteAccountVC: UIViewController {

    private var currentState: DeleteAccountStatus = .deleteStart {
        didSet {
            updateUIforState()
        }
    }

    private let promptTitle: String
    private let promptDescription: String
    weak var delegate: DeleteAccountVCdelegate?

    // MARK: - Subviews

    private lazy var labelsContainerView: UIView = { view in
        view.backgroundColor = .clear
        return view
    }(UIView())

    lazy var titleLabel: UILabel = { label in
        label.text = L10n.Prompt.title
        label.font = .font(.ubuntuBold700, size: 24)
        label.textColor = .black
        label.setLineHeight(28)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.Prompt.DeleteAccount.description
        label.font = .font(.ubuntuRegular400, size: 14)
        label.textColor = .tableViewTitleLabel
        label.setLineHeight(22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cancelButton: CommonButton = { button in
        button.setButtonTitle(L10n.Prompt.Action.cancel)
        button.borderColor = .blue
        button.borderWidth = 1
        button.layer.cornerRadius = 16
        return button
    }(CommonButton(style: .destructive))

    lazy var confirmButton: CommonButton = { button in
        button.cornerRadius = 16
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

    @objc func updateUIforState() {
        switch currentState {
        case .followDelete:
            descriptionLabel.text = promptTitle
        case .deleteStart:
            self.title = L10n.Prompt.DeleteAccount.sureAction
            currentState = .followDelete
            descriptionLabel.text = title
            cancelButton.setButtonTitle(L10n.Prompt.Action.cancel)
            cancelButton.changeStyleToCancel()
        }
    }

}

private extension DeleteAccountVC {
    func setupViews_unique() {
        view.backgroundColor = .white

        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 12

        labelsContainerView.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints {
//            $0.height.equalTo(78)
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = 12

        view.addSubviews(labelsContainerView, buttonsStackView)
        labelsContainerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(140)
        }
        buttonsStackView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(labelsContainerView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(128)
        }
    }

    func setupActions_unique() {
        cancelButton.addTarget(self, action: #selector(cancelTapped_unique(_:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(updateUIforState), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmTapped_unique(_:)), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func cancelTapped_unique(_ sender: CommonButton) {
        if currentState == .followDelete {
            func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
                print(qFvvUwywod)
                print("\(rkjyOdUzcU)")
                return "\(qFvvUwywod) \(rkjyOdUzcU)"
            }

            delegate?.promptViewControllerCancelTapped(self)
        }
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
