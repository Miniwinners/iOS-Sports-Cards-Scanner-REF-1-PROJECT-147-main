import UIKit
import SnapKit

enum ButtonStyleDeleteLogout {
   case delete
    case logOut
}

final class DeleteAccountVC: UIViewController {

    private let promptTitle: String
    private let promptDescription: String
    weak var delegate: DeleteAccountVCdelegate?
    private var styleButton: ButtonStyleDeleteLogout
    // MARK: - Subviews

    private lazy var labelsContainerView: UIView = { view in
        view.backgroundColor = .clear
        return view
    }(UIView())

    lazy var titleLabel: UILabel = { label in
        label.text = promptTitle
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 30:24)
        label.textColor = .black
        label.setLineHeight(UIDevice.isIpad ? 32:28)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var descriptionLabel: UILabel = { label in
        label.text = promptDescription
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)
        label.textColor = .tableViewTitleLabel
        label.setLineHeight(UIDevice.isIpad ? 24:22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cancelButton: CommonButton = {
        var button = CommonButton(style: .destructive)
        switch styleButton {
        case .delete: button = CommonButton(style: .cancel2)
        case .logOut: button = CommonButton(style: .cancel)
        }
//        button.borderColor = .blue
//        button.borderWidth = 1
//        button.layer.cornerRadius = UIDevice.isIpad ? 22 : 16
        return button
    }()

    lazy var confirmButton: CommonButton = { button in
        button.cornerRadius = UIDevice.isIpad ? 22:16
        return button
    }(CommonButton(style: .default))

    init(title: String = L10n.Prompt.title, description: String, styleButton: ButtonStyleDeleteLogout) {
        self.promptTitle = title
        self.promptDescription = description
        self.styleButton = styleButton
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

private extension DeleteAccountVC {
    func setupViews_unique() {
        view.backgroundColor = .white

        let labelsStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = UIDevice.isIpad ? 30:12

        labelsContainerView.addSubview(labelsStackView)
        labelsStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        let buttonsStackView = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.spacing = UIDevice.isIpad ? 20:12

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
            $0.height.equalTo(UIDevice.isIpad ? 180:128)
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
