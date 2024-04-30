import UIKit
import SnapKit
import Kingfisher

final class PricingReportDetailsView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        label.textColor = .black
        label.numberOfLines = 2
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var subtitleLabel: UILabel = { label in
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 24:18)
        label.textColor = .black
        label.numberOfLines = 2
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }(UILabel())

    private lazy var priceReportView: DetailView = .init()
    private lazy var lastSoldPriceView: DetailView = .init()
    private lazy var lastSoldDateView: DetailView = .init()

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 9
        return imageView
    }(UIImageView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

}

extension PricingReportDetailsView {
    func set(card: CardRepresentable, grader: CardGrader) {
        titleLabel.text = card.title
        subtitleLabel.text = card.subtitle
        titleLabel.setLineHeight(UIDevice.isIpad ? 26:22)
        subtitleLabel.setLineHeight(UIDevice.isIpad ? 24:21.6)

        if let priceRange = card.priceRange(of: grader) {
            let firstPartTitle = "\(L10n.PricingReport.Details.priceReport) - "
            let secondPartTitle = grader.rawValue
            let fullTitle = firstPartTitle + secondPartTitle
            let attributedTitle = NSMutableAttributedString(string: fullTitle)
            attributedTitle.addAttributes(
                [.foregroundColor: UIColor.labelColor4],
                range: .init(location: 0, length: firstPartTitle.count)
            )
            attributedTitle.addAttributes(
                [.foregroundColor: UIColor.cardBackColor],
                range: .init(location: firstPartTitle.count, length: secondPartTitle.count)
            )
            priceReportView.setReportTitle(attributedTitle)
            priceReportView.setDetailsInfo(priceRange)
        } else {
            priceReportView.isHidden = true
        }

        if let formattedPrice = card.lastSoldPrice(of: grader) {
            lastSoldPriceView.setReportTitle(L10n.PricingReport.Details.lastSoldPrice)
            lastSoldPriceView.setDetailsInfo(formattedPrice)
        } else {
            lastSoldPriceView.isHidden = true
        }

        if let formattedDate = card.lastSoldDate(of: grader) {
            lastSoldDateView.setReportTitle(L10n.PricingReport.Details.lastSoldDate)
            lastSoldDateView.setDetailsInfo(formattedDate)
        } else {
            lastSoldDateView.isHidden = true
        }
    }

    func set(encodedCardImage: Data) {
        photoView.image = UIImage(data: encodedCardImage)
    }

    func set(imageURL: URL) {
        photoView.kf.setImage(with: imageURL)
    }

    private func setupSubviews_unique() {
        backgroundColor = .white
        cornerRadius = 12

        let stackView = UIStackView(arrangedSubviews: [priceReportView, lastSoldPriceView, lastSoldDateView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 9

        let detailsContainerView = UIView()
        detailsContainerView.addSubviews(titleLabel, subtitleLabel, stackView)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        let containerView = UIView()
        containerView.addSubviews(detailsContainerView, photoView)
        detailsContainerView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.high)
        }
        photoView.snp.makeConstraints {
            $0.width.equalTo(119)
            $0.height.equalTo(165)
            $0.top.trailing.equalToSuperview()
            $0.leading.equalTo(detailsContainerView.snp.trailing).offset(8)
            $0.bottom.lessThanOrEqualToSuperview()
        }

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

// MARK: - DetailView

extension PricingReportDetailsView {
    fileprivate class DetailView: UIView {
        private var titleLabel: UILabel!
        private var infoLabel: UILabel!
    }
}

extension PricingReportDetailsView.DetailView {
    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setReportTitle(_ title: String) {
        let attributedTitle = NSAttributedString(string: title)
        setReportTitle(attributedTitle)
    }

    func setReportTitle(_ attributedTitle: NSAttributedString) {
        let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
        addParagraphStyle(to: mutableAttributedTitle)

        titleLabel.attributedText = mutableAttributedTitle
    }

    func setDetailsInfo(_ info: String) {
        let attributedInfo = NSAttributedString(string: info)
        setDetailsInfo(attributedInfo)
    }

    func setDetailsInfo(_ attributedInfo: NSAttributedString) {
        let mutableAttributedInfo = NSMutableAttributedString(attributedString: attributedInfo)
        addParagraphStyle(to: mutableAttributedInfo)

        infoLabel.attributedText = mutableAttributedInfo
    }

    private func addParagraphStyle(to attributedText: NSMutableAttributedString) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.14
        attributedText.addAttributes(
            [.paragraphStyle: paragraphStyle],
            range: NSRange(location: 0, length: attributedText.length)
        )
    }

    private func setupSubviews_unique() {
        titleLabel = .init()
        titleLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        titleLabel.textColor = .black
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }

        infoLabel = .init()
        infoLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        infoLabel.textColor = .greenColor
        infoLabel.setContentHuggingPriority(.required, for: .vertical)
        addSubview(infoLabel)
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
