import UIKit
import SnapKit
func vicheslitFibonc314(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
class SportivinieKartiTTextPoleVid: UIView {
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }

    var text: String { textField.text ?? "" }

    var placeholder: String {
        get { textField.attributedPlaceholder?.string ?? "" }
        set { textField.placeholder = newValue }
    }

    lazy var validImage: UIImageView = { image in
        image.image = SportivinieKartiImages.validEmail.image
        image.isHidden = true
        return image
    }(UIImageView())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        label.textColor = .logInLabel
        label.numberOfLines = 0
        return label
    }(UILabel())

    lazy var textField: SportivinieKartiCustomTextPole = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)
        textField.backgroundColor = .skyBlue
        textField.textColor = .logInLabel
        textField.cornerRadius = 16
        textField.tintColor = .logInLabel

        return textField
    }(SportivinieKartiCustomTextPole())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }
}

private extension SportivinieKartiTTextPoleVid {
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
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 30:24)
        }

        textField.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 80:56)
        }

        let stackView = UIStackView(arrangedSubviews: [titleLabel, textField])
        stackView.axis = .vertical
        stackView.spacing = UIDevice.isIpad ? 20:8
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        textField.addSubview(validImage)
        validImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(UIDevice.isIpad ? 40:28)
            $0.right.equalToSuperview().inset(UIDevice.isIpad ? 15:10)
        }
    }
}
