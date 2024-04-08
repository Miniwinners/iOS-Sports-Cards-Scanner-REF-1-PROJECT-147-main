import UIKit
import SnapKit
import Kingfisher

final class CardSaleTableViewCell: UITableViewCell {

    private static let containerHeight: CGFloat = 146

    lazy var containerView: UIView = .init()

    lazy var dateLabel: UILabel = { label in
        label.textColor = .labelColor3
        label.font = .font(.interSemibold, size: 13)
        return label
    }(UILabel())

    lazy var titleLabel: UILabel = { label in
        label.textColor = .labelColor4
        label.font = .font(.interMedium, size: 16)
        label.numberOfLines = 3
        return label
    }(UILabel())

    lazy var cardImageView: UIImageView = { imageView in
        imageView.cornerRadius = 6
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var missingImageLabel: UILabel = { label in
        label.text = L10n.Card.missingImage
        label.setLineHeight(19)
        label.textColor = .labelColor3
        label.font = .font(.interRegular, size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var missingImageView: UIView = { view in
        view.cornerRadius = 6
        view.backgroundColor = .backColor
        return view
    }(UIView())

    lazy var priceLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .greenColor
        return label
    }(UILabel())

    lazy var separatorView: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        missingImageLabel.isHidden = false
        cardImageView.kf.cancelDownloadTask()
        cardImageView.kf.setImage(with: URL(string: ""))
        cardImageView.image = nil
    }

    func setSale(_ sale: CardSale) {
        dateLabel.text = sale.formattedDate
        dateLabel.setLineHeight(22)
        titleLabel.text = sale.title
        titleLabel.setLineHeight(22)
        priceLabel.text = sale.formattedPrice
        priceLabel.setLineHeight(22)
        if let imageURL = sale.thumbnailURL {
            missingImageLabel.isHidden = true
            cardImageView.kf.setImage(with: imageURL)
        }
    }

    func setBottomSpace(hidden: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        separatorView.isHidden = hidden
    }
}

private extension CardSaleTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundView = createBackgroundView()
        selectedBackgroundView = createHighlightedView()

        let stackView = UIStackView(arrangedSubviews: [containerView, separatorView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        containerView.addSubviews(dateLabel, titleLabel, priceLabel, missingImageView, cardImageView)
        containerView.snp.makeConstraints {
            $0.height.equalTo(Self.containerHeight).priority(.high)
        }
        dateLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
        }
        cardImageView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(82)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(16)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(16)
        }
        missingImageView.snp.makeConstraints {
            $0.edges.equalTo(cardImageView)
        }

        missingImageView.addSubview(missingImageLabel)
        missingImageLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        separatorView.snp.makeConstraints {
            $0.height.equalTo(16)
        }
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.cornerRadius = 12
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(Self.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    func createHighlightedView() -> UIView {
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        highlightedView.cornerRadius = 12
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(Self.containerHeight + 1)
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return highlightedContainerView
    }

}
