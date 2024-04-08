import UIKit

final class ResetPasswordViewController: UIViewController {

    // MARK: - Subviews

    lazy var resetPasswordView: ResetPasswordView = .init()

    private let email: String
    weak var delegate: ResetPasswordViewControllerDelegate?

    init(email: String) {
        self.email = email
        super.init(nibName: nil, bundle: nil)

        title = L10n.ResetPassword.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = resetPasswordView
    }

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

private extension ResetPasswordViewController {
    func setupViews_unique() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = .init(
            image: Images.close.image,
            style: .plain,
            target: self,
            action: #selector(closeTapped_unique)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black

        resetPasswordView.emailSendLabel.text = L10n.ResetPassword.emailSent(email)
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.resetPasswordViewControllerCloseTapped(self)
    }
}

extension ResetPasswordViewController: SwipableController {
    var isSwipeBackEnabled: Bool { false }
}
