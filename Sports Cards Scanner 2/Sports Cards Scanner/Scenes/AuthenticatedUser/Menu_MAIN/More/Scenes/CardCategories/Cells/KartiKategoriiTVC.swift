import UIKit
import SnapKit
func vicheslitFibonc225(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

// protocol MakeTimeWaitDelegate: AnyObject {
//    func wait()
// }

final class SportivinieKartiKartiKategoriiTableKlrtka: UITableViewCell {

    lazy var containerView: UIView = .init()

    lazy var reorderImageView: UIImageView = { image in
        return image
    }(UIImageView())

    lazy var titleLabel: UILabel = { label in
        label.textColor = .logInLabel
        label.postavitRazmer(fontS: .ubuntuMedium500, phone: 16, iPad: 22)
        return label
    }(UILabel())

    lazy var switchView: UISwitch = { switchV in
        return switchV
    }(UISwitch())
//    let switchView = UISwitch()
//    weak var delegate: MakeTimeWaitDelegate?

    private var topConstraint: Constraint!
    private var bottomConstraint: Constraint!

    private var onCategoryDidSwitch: BoolClosure?

    private(set) var cellPosition: SportivinieKartiPoziciaKletki?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
        self.isMultipleTouchEnabled = false

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func postavitCellKategorii(with categoryModel: KartaKategoriiModel, onCategoryDidSwitch: @escaping BoolClosure) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        titleLabel.text = categoryModel.category.title
        switchView.setOn(categoryModel.isEnabled, animated: false)
        reorderImageView.image = categoryModel.category.image
        self.onCategoryDidSwitch = onCategoryDidSwitch
    }

    func obnovitPoziciuCell(_ position: SportivinieKartiPoziciaKletki) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if cellPosition == position { return }
        cellPosition = position

    }

    func postavitSwitchVikluchit(available: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        guard switchView.isOn else { return }

        switchView.isEnabled = available
    }
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//
//        return self.frame.contains(point)
//
//    }
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//    // Check if the touch point is within the bounds of the switchView subview
//    let convertedPoint = self.convert(point, to: switchView)
//    if switchView.bounds.contains(convertedPoint) {
//   //здесь переключи свитч
//    return self.view
//    }
//    return super.hitTest(point, with: event)
//    }
}

private extension SportivinieKartiKartiKategoriiTableKlrtka {
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
        contentView.backgroundColor = .clear
        containerView.backgroundColor = .skyBlue
        containerView.layer.cornerRadius = 16
        selectionStyle = .none

        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 90 : 20)
        }

        containerView.addSubview(reorderImageView)
        reorderImageView.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 30:22 )
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()

//            topConstraint = $0.top.equalToSuperview().inset(17).constraint
//            bottomConstraint = $0.bottom.equalToSuperview().inset(17).priority(.high).constraint
        }

        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(reorderImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(reorderImageView)
        }

        containerView.addSubview(switchView)
        switchView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(reorderImageView)
            $0.trailing.equalToSuperview().inset(16)
        }

        backgroundView = sodatZadniiVid()

        switchView.addTarget(self, action: #selector(switchStatusIzmenen(_:)), for: .valueChanged)
//        self.isExclusiveTouch = true
    }

    func sodatZadniiVid() -> UIView {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    @objc func switchStatusIzmenen(_ sender: UISwitch) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        onCategoryDidSwitch?(sender.isOn)
//        delegate?.wait()
    }
}
