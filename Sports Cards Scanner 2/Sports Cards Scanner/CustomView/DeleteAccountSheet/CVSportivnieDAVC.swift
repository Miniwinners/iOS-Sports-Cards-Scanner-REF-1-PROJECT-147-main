import UIKit
import SnapKit
func vicheslitFibonc329(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
func randomniiParol(length: Int) -> String {
    let characters = "a!@#$%^&*"
    let randomPassword = String((0..<length).map { _ in characters.randomElement()! })
    return randomPassword
}
enum ButtonStyleDeleteLogout {
    case delete
    case logOut
}

final class SportivinieKartiDAVC: UIViewController {

    private let promptTitle: String
    private let promptDescription: String
    weak var delegate: SportivinieKartiDAVCD?
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
        label.setVisotaLabla(UIDevice.isIpad ? 32:28)
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
        label.setVisotaLabla(UIDevice.isIpad ? 24:22)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var cancelButton: SportivinieKartiCommonB = {
        var button = SportivinieKartiCommonB(style: .destructive)
        switch styleButton {
        case .delete: button = SportivinieKartiCommonB(style: .cancel2)
        case .logOut: button = SportivinieKartiCommonB(style: .cancel)
        }
        return button
    }()

    lazy var confirmButton: SportivinieKartiCommonB = { button in
        button.cornerRadius = UIDevice.isIpad ? 22:16
        return button
    }(SportivinieKartiCommonB(style: .default))

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

        super.viewDidLoad()

        postavitVid()
        postavidDeistviaUnicalno()
    }

}

private extension SportivinieKartiDAVC {
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

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cancelButton.addTarget(self, action: #selector(otmenaNazhata(_:)), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(podtverditNazhata(_:)), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func otmenaNazhata(_ sender: SportivinieKartiCommonB) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }

        delegate?.promptViewControllerotmenaNazhata(self)

    }

    @objc func podtverditNazhata(_ sender: SportivinieKartiCommonB) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        delegate?.promptViewControllerPodtverditYdalitNazhata(self)

    }
}
