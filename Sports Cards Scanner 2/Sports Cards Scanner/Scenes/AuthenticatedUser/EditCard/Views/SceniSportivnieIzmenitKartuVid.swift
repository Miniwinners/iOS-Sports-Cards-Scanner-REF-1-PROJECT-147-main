import UIKit
import SnapKit
func vicheslitFibonc268(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiIzmenitKartuVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var parallelDetailView: SportivinieKartiIzmenitKartuDetaliVid = { view in
        view.postavitImyaDetali(L10n.EditCard.parallel)
        view.isUserInteractionEnabled = false
        return view
    }(SportivinieKartiIzmenitKartuDetaliVid())

    lazy var gradeDetailView: SportivinieKartiIzmenitKartuDetaliVid = { view in
        view.postavitImyaDetali(L10n.EditCard.grade)
        view.discloseImageView.image = SportivinieKartiImages.gradeStar.image
        view.isUserInteractionEnabled = false
        return view
    }(SportivinieKartiIzmenitKartuDetaliVid())

    lazy var parallelDetailButton: SportivinieKartiCommonKnopka = .init(style: .custom(buttonAppearance))
    lazy var gradeDetailButton: SportivinieKartiCommonKnopka = .init(style: .custom(buttonAppearance))

    lazy var updateDetailsButton: SportivinieKartiCommonKnopka = { button in
        button.setButtonTitle(L10n.EditCard.Action.updateDetails)
        return button
    }(SportivinieKartiCommonKnopka(style: .default))

    lazy var setPriceLabel: UILabel = { label in
        label.text = L10n.EditCard.customPrice
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        return label
    }(UILabel())

    lazy var priceTextField: SportivinieKartiCustomTextPole = { textField in
        textField.borderStyle = .none
        textField.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22: 16)
        textField.backgroundColor = .skyBlue
        textField.cornerRadius = UIDevice.isIpad ? 28:12
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .decimalPad
        return textField
    }(SportivinieKartiCustomTextPole())

    lazy var customPriceLabel: UILabel = { label in
        label.textColor = .greenColor
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 24:18)
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

}

private extension SportivinieKartiIzmenitKartuVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    var buttonAppearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = UIDevice.isIpad ? 32:12
        return .init(configuration: configuration, backgroundColors: .init(primary: .skyBlue, highlighted: .highlightColor2))
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
        parallelDetailButton.addSubview(parallelDetailView)
        parallelDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        parallelDetailButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 200:64)
        }

        gradeDetailButton.addSubview(gradeDetailView)
        gradeDetailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        gradeDetailButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 200:64)
        }

        priceTextField.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 115:65)
        }
        backView.addSubview(priceTextField)

        let stackView = UIStackView(arrangedSubviews: [gradeDetailButton, parallelDetailButton])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        backView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 30:10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.height.equalTo(UIDevice.isIpad ? 200:130)
        }

        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(UIDevice.isIpad ? 40:20)
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        priceTextField.postavirPhotoUnicalno(
            SportivinieKartiImages.MenuKollekcii.renameCollection.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )

        priceTextField.addSubview(customPriceLabel)
        customPriceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(UIDevice.isIpad ? 30:16)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            $0.height.equalTo(UIDevice.isIpad ? 24:18)
        }
        priceTextField.addSubview(setPriceLabel)
        setPriceLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(UIDevice.isIpad ? 22:16)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            $0.height.equalTo(UIDevice.isIpad ? 24:18)
        }
        backView.addSubview(updateDetailsButton)
        updateDetailsButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 80:54)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 60:20)
        }
    }
}
