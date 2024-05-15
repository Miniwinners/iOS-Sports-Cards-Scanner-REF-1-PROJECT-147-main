import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc167(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCenaOcenkaDetaliVid: UIView {
    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 30:22)
        label.textColor = .black
        label.numberOfLines = 2
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var subtitleLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 28:16)
        label.textColor = .black
        label.numberOfLines = 2
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    private lazy var priceReportView: DetailView = .init()
    private lazy var lastSoldPriceView: DetailView = .init()
    private lazy var lastSoldDateView: DetailView = .init()
    private lazy var priceView: DetailView = .init()
    private lazy var containerView: UIView = .init()
    lazy var stackViewIpad: UIView = .init()
    lazy var priceContainer: UIView = .init()
    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 9
        return imageView
    }(UIImageView())

    convenience init() {
        self.init(frame: .zero)
        postavitVid()
    }

}

extension SportivinieKartiCenaOcenkaDetaliVid {
    func postavit(card: SportivinieKartiKartaPredstavlenie, grader: SportivinieKartiKartaGrader) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        titleLabel.text = card.title
        titleLabel.textAlignment = .center

        subtitleLabel.text = card.subtitle
        subtitleLabel.textAlignment = .center
        titleLabel.setVisotaLabla(UIDevice.isIpad ? 34:24)
        subtitleLabel.setVisotaLabla(UIDevice.isIpad ? 30:18)

        if let priceRange = card.diapazonCen(of: grader) {

            priceReportView.postavitOcenkaZagolovok("Price") // L10n.PricingReport.Details.priceReport
            priceReportView.postavitInfoZnachenie(priceRange)
        } else {
            priceReportView.isHidden = true
        }

        if let formattedPrice = card.posledniaCenaProdazhi(of: grader) {
            lastSoldPriceView.postavitOcenkaZagolovok(postavitAtributStrky(text: L10n.PricingReport.Details.lastSoldPrice, textToCut: grader.rawValue))
            lastSoldPriceView.postavitInfoZnachenie(formattedPrice)

            priceView.postavitOcenkaZagolovok("Price")
            priceView.postavitInfoZnachenie(formattedPrice)
        } else {
            lastSoldPriceView.isHidden = true
        }

        if let formattedDate = card.posledniaDataProdazhi(of: grader) {
            lastSoldDateView.postavitOcenkaZagolovok(postavitAtributStrky(text: L10n.PricingReport.Details.lastSoldDate, textToCut: grader.rawValue))
            lastSoldDateView.postavitInfoZnachenie(formattedDate)
        } else {
            lastSoldDateView.isHidden = true
        }

    }

    func postavitAtributStrky(text: String, textToCut: String) -> NSMutableAttributedString {
        let fulltext = "\(text) - \(textToCut)"
        let atributeString = NSMutableAttributedString(string: fulltext)
        let range = (fulltext as NSString).range(of: textToCut)
        if range.location != NSNotFound {
            atributeString.addAttribute(.foregroundColor, value: UIColor.black, range: range)
        }
        return atributeString
    }

    func postavit(encodedCardImage: Data) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        photoView.image = UIImage(data: encodedCardImage)
    }

    func postavit(imageURL: URL) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        photoView.kf.setImage(with: imageURL)
    }

    private func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        backgroundColor = .white

        priceContainer.backgroundColor = .skyBlue
        priceContainer.cornerRadius = 12
//        priceContainer.borderColor = .blue
//        priceContainer.borderWidth = 1

        let detailsContainerView = UIView()
        detailsContainerView.addSubviews(titleLabel, subtitleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5)
            $0.centerX.equalToSuperview()
        }

        containerView.addSubviews(detailsContainerView, photoView)
        detailsContainerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 80:60)
        }
        photoView.snp.makeConstraints {
            $0.width.equalTo(UIDevice.isIpad ? 300:168)
            $0.height.equalTo(UIDevice.isIpad ? 450:242)
            $0.top.equalTo(detailsContainerView.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        if UIDevice.isIpad { designForIpad() } else { dedignForIphone() }

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()

        }

    }
    func designForIpad() {
        let stackView = UIStackView(arrangedSubviews: [priceView, priceReportView, lastSoldDateView, lastSoldPriceView])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackViewIpad.backgroundColor = .skyBlue
        stackViewIpad.cornerRadius = 14
        stackView.distribution = .equalSpacing
        containerView.addSubview(stackViewIpad)
        stackViewIpad.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(40)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)

        }
        stackViewIpad.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(90)
        }
    }

    func dedignForIphone() {
        priceContainer.addSubviews(priceView, priceReportView, lastSoldPriceView, lastSoldDateView)
        priceView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(15)

        }
        priceReportView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.leading.equalToSuperview().inset(15)
        }

        lastSoldPriceView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(15)
        }

        lastSoldDateView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.trailing.equalToSuperview().inset(15)
        }
        containerView.addSubview(priceContainer)
        priceContainer.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(130)
        }
    }

}

// MARK: - DetailView

extension SportivinieKartiCenaOcenkaDetaliVid {
    fileprivate class DetailView: UIView {
        private var titleLabel: UILabel!
        private var infoLabel: UILabel!
    }
}

extension SportivinieKartiCenaOcenkaDetaliVid.DetailView {
    convenience init() {
        self.init(frame: .zero)
        postavitVid()
    }

    func postavitOcenkaZagolovok(_ title: String) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let attributedTitle = NSAttributedString(string: title)
        postavitOcenkaZagolovok(attributedTitle)
    }

    func postavitOcenkaZagolovok(_ attributedTitle: NSAttributedString) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
        dobavitParagraf(to: mutableAttributedTitle)

        titleLabel.attributedText = mutableAttributedTitle
    }

    func postavitInfoZnachenie(_ info: String) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let attributedInfo = NSAttributedString(string: info)
        postavitInfoZnachenie(attributedInfo)
    }

    func postavitInfoZnachenie(_ attributedInfo: NSAttributedString) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let mutableAttributedInfo = NSMutableAttributedString(attributedString: attributedInfo)
        dobavitParagraf(to: mutableAttributedInfo)

        infoLabel.attributedText = mutableAttributedInfo
    }

    private func dobavitParagraf(to attributedText: NSMutableAttributedString) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        attributedText.addAttributes(
            [.paragraphStyle: paragraphStyle],
            range: NSRange(location: 0, length: attributedText.length)
        )
    }

    private func postavitVid() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        titleLabel = .init()
        titleLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 18:16)
        titleLabel.textColor = .labelColor4
//        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 20:0)
            $0.height.equalTo(20)
        }

        infoLabel = .init()
        infoLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 18:16)
        infoLabel.textColor = .greenColor
//        infoLabel.setContentHuggingPriority(.required, for: .vertical)
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 10:4)
            $0.height.equalTo(20)
            $0.horizontalEdges.equalToSuperview()
        }
    }
}
