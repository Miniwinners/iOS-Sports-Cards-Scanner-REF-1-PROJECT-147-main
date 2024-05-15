import UIKit
import SnapKit
func vicheslitFibonc278(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiFPV: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var descriptionView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.ForgotPassword.description
        label.textColor = .labelColor
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var contentView: UIStackView = { stackView in
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 20
        return stackView
    }(UIStackView(arrangedSubviews: [errorLabel, emailView]))

    lazy var emailView: SportivinieKartiTTextFV = { view in
        view.title = L10n.ForgotPassword.Email.title
        view.placeholder = L10n.ForgotPassword.Email.placeholder
        view.textField.keyboardType = .emailAddress
        view.textField.autocorrectionType = .no
        view.textField.autocapitalizationType = .none
        view.textField.returnKeyType = .done
        return view
    }(SportivinieKartiTTextFV())

    lazy var errorLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 18:14)
        label.textColor = .errorColor
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var sendButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.ForgotPassword.Action.send)
        return button
    }(SportivinieKartiCommonB(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

}

private extension SportivinieKartiFPV {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        backView.postavitVid(in: self)
        titleLabel.postavitLabel(in: backView)

        addSubview(descriptionView)
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        descriptionView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        addSubview(sendButton)
        sendButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 50:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(54)
        }
    }
}
