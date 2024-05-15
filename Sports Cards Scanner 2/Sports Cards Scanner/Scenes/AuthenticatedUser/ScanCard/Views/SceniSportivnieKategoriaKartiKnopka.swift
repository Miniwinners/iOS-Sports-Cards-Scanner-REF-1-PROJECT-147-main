import UIKit
import SnapKit
func vicheslitFibonc215(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKategoriaKartiKnopka: UIButton {

    var cardCategory: KategoriiKart? {
        didSet { categoryLabel.text = cardCategory?.title ?? "" }
    }

    lazy var categoryLabel: UILabel = { label in
        label.text = cardCategory?.title ?? ""
        label.textColor = .black
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = .init(image: SportivinieKartiImages.disclosureBottom.image)

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layer.cornerRadius = UIDevice.isIpad ? 24:10
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConfiguration() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        switch state {
        case .highlighted:
            categoryLabel.textColor = .highlightColor
            disclosureImageView.tintColor = .highlightColor
        default:
            categoryLabel.textColor = .black
            disclosureImageView.tintColor = .black
        }
    }

}

private extension SportivinieKartiKategoriaKartiKnopka {
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
        let leftSpacer = UIView()
        let rightSpacer = UIView()

        configuration = .plain()
        disclosureImageView.snp.makeConstraints {
            $0.width.equalTo(UIDevice.isIpad ? 32:16)
            $0.height.equalTo(UIDevice.isIpad ? 18:9)
        }
        leftSpacer.snp.makeConstraints { $0.width.equalTo(10) }
        rightSpacer.snp.makeConstraints { $0.width.equalTo(5) }
        let stackView = UIStackView(arrangedSubviews: [leftSpacer, categoryLabel, disclosureImageView, rightSpacer])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.isUserInteractionEnabled = false
        stackView.spacing = 10
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
