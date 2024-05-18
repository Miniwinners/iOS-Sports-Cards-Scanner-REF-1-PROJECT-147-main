import UIKit
import SnapKit
func vicheslitFibonc195(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartaKollekciiNetKartVid: UIView {

    lazy var containerView: UIView = { view in
        view.backgroundColor = .skyBlue
        view.cornerRadius = UIDevice.isIpad ? 26:16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        return view
    }(UIView())

    lazy var nameLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 30:24)
        label.textColor = .black
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var titleLabel: TitleLabel = { label in
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(TitleLabel())

    lazy var menuButton: UIButton = { button in
        button.setImage(SportivinieKartiImages.menuDots.image, for: .normal)
        button.tintColor = .black
        return button
    }(UIButton(type: .system))

    lazy var priceContainerView: UIView = .init()

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 28:22)
        label.textColor = .black
        label.text = Double.zero.formattedAsPrice
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var estimatedValueLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)
        label.textColor = .black
        label.text = L10n.CardCollection.estimatedValue
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var noCardsView: SportivinieKartiCustomMessageVid = { view in
        view.postavitZagolovok(L10n.CardCollection.noCards)
        return view
    }(SportivinieKartiCustomMessageVid())

    lazy var addCardsButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.CardCollection.Action.addCards)
        button.setImage(SportivinieKartiImages.addPlus2.image, for: .normal)
        button.configuration?.imagePadding = 20
        return button
    }(SportivinieKartiCommonKnopka(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

    func postavitImyaKollekcii(_ name: String?) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        titleLabel.text = name
    }

    func pokazatEstimateZnachenie() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard containerView.superview == nil else { return }

        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.height.equalTo(UIDevice.isIpad ? 216:125)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        containerView.addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.bringSubviewToFront(menuButton)
    }

    func spryataEstimaeZnachenie() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        containerView.removeFromSuperview()
    }
}

private extension SportivinieKartiKartaKollekciiNetKartVid {

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
        titleLabel.postavitLabel(in: self)

        priceContainerView.addSubviews(estimatedValueLabel, priceLabel)

        estimatedValueLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
        }

        priceLabel.snp.makeConstraints {
            $0.bottom.centerX.equalToSuperview()
            $0.top.equalTo(estimatedValueLabel.snp.bottom).offset(5)
        }

        self.addSubview(menuButton)
        containerView.addSubview(priceContainerView)
        priceContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        addSubviews(containerView, noCardsView, addCardsButton)
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            $0.height.equalTo(UIDevice.isIpad ? 216:125)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }
        noCardsView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 124:70)
        }
        addCardsButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:20)
        }
        self.addSubview(menuButton)
        menuButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 130:100)
            $0.right.equalToSuperview().inset(UIDevice.isIpad ? 40:30)
            $0.size.equalTo(UIDevice.isIpad ? 42:24)
        }
    }
}
