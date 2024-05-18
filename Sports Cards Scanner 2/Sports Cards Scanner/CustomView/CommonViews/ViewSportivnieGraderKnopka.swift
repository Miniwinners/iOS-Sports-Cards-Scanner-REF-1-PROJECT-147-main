import UIKit
import SnapKit
func vicheslitFibonc315(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCGraderKnopka: UIButton {

    var cardGrader: SportivinieKartiKartaGrader? {
        didSet { graderLabel.text = cardGrader?.rawValue ?? "" }
    }

    lazy var graderLabel: UILabel = { label in
        label.text = cardGrader?.rawValue ?? ""
        label.textColor = .logInLabel
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = { imageView in
        imageView.tintColor = .labelColor4
        return imageView
    }(UIImageView(image: SportivinieKartiImages.disclosureBottom.image))

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    init() {
        super.init(frame: .zero)

        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConfiguration() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        switch state {
        case .highlighted:
            graderLabel.textColor = .highlightColor
            disclosureImageView.tintColor = .highlightColor2
        default:
            graderLabel.textColor = .labelColor
            disclosureImageView.tintColor = .labelColor4
        }
    }

}

private extension SportivinieKartiCGraderKnopka {
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
        configuration = .plain()

        disclosureImageView.snp.makeConstraints {
            $0.width.equalTo(UIDevice.isIpad ? 24:16)
            $0.height.equalTo(UIDevice.isIpad ? 13:9)
        }

        let stackView = UIStackView(arrangedSubviews: [graderLabel, disclosureImageView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false

        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(12)
            $0.verticalEdges.equalToSuperview().inset(10)
        }

        addSubview(underlineView)
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
