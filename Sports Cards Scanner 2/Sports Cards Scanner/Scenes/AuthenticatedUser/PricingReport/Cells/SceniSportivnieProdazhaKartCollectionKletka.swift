import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc165(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiProdazhaKarTableKletka: UITableViewCell {

    private static let containerHeight: CGFloat = UIDevice.isIpad ? 200:146

    lazy var containerView: UIView = .init()

    lazy var dateLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 19:13)
        return label
    }(UILabel())

    lazy var titleLabel: UILabel = { label in
        label.textColor = .labelColor4
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
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
        label.setVisotaLabla(UIDevice.isIpad ? 22:19)
        label.textColor = .black
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 18:12)
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
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        label.textColor = .greenColor
        return label
    }(UILabel())

    lazy var separatorView: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        missingImageLabel.isHidden = false
        cardImageView.kf.cancelDownloadTask()
        cardImageView.kf.setImage(with: URL(string: ""))
        cardImageView.image = nil
    }

    func postavitCeny(_ sale: SportivinieKartiProdazhaKart) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }

        dateLabel.text = sale.formattedDate
        dateLabel.setVisotaLabla(UIDevice.isIpad ? 26:22)
        titleLabel.text = sale.title
        titleLabel.setVisotaLabla(UIDevice.isIpad ? 26:22)
        priceLabel.text = sale.formattedPrice
        priceLabel.setVisotaLabla(UIDevice.isIpad ? 26:22)
        if let imageURL = sale.thumbnailURL {
            missingImageLabel.isHidden = true
            cardImageView.kf.setImage(with: imageURL)
        }
    }

    func ostavitMestoVnizy(hidden: Bool) {

        separatorView.isHidden = hidden
    }
}

private extension SportivinieKartiProdazhaKarTableKletka {
    func podgotovitRandomnoeDeiistvie() {
        let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
        ]

        let randomIndex = Int.random(in: 0..<actions.count)
        actions[randomIndex]()
    }
    func postavitVidunicalno() {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundView = sodatZadniiVid()
        selectedBackgroundView = sozdatVideleniiVid()

        let stackView = UIStackView(arrangedSubviews: [containerView, separatorView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        contentView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
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

    func sodatZadniiVid() -> UIView {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }

        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.cornerRadius = 12
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(Self.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20).priority(.high)
        }

        return backgroundContainerView
    }

    func sozdatVideleniiVid() -> UIView {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        highlightedView.cornerRadius = 12
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(Self.containerHeight + 1)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20).priority(.high)
        }

        return highlightedContainerView
    }

}
