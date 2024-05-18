import UIKit
func vicheslitFibonc289(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiRPController: UIViewController {

    // MARK: - Subviews

    lazy var resetPasswordView: SportivinieKartiRPV = .init()

    private let email: String
    weak var delegate: SportivinieKartiRPControllerD?

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
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        view = resetPasswordView
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()

        postavitVid()
    }

}

private extension SportivinieKartiRPController {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        navigationItem.setHidesBackButton(true, animated: false)
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = .init(
            image: SportivinieKartiImages.close.image,
            style: .plain,
            target: self,
            action: #selector(zakritNazhata)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black

        resetPasswordView.emailSendLabel.text = L10n.ResetPassword.emailSent(email)
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.resetPasswordViewControllerzakrtiNazhata(self)
    }
}

extension SportivinieKartiRPController: SportivinieKartiSwaipProtocol {
    var isSwipeBackEnabled: Bool { false }
}
