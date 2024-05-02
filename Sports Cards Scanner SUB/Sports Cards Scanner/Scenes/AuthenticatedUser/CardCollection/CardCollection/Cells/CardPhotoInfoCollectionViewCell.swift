import UIKit
import SnapKit
import Kingfisher

final class CardPhotoInfoCollectionViewCell: UICollectionViewCell {

    static func calculateCellHeight(for cellWidth: CGFloat) -> CGFloat {
        let photoWidth = cellWidth - 12
        let photoHeight = photoWidth * 1.41
        return photoHeight + 46
    }

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = UIDevice.isIpad ? 20:10
        return imageView
    }(UIImageView())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.interRegular, size: UIDevice.isIpad ? 16:10)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var subtitleLabel: UILabel = { label in
        label.font = .font(.interRegular, size: UIDevice.isIpad ? 16:10)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var overlayView: UIView = { view in
        view.cornerRadius = UIDevice.isIpad ? 20:10
        return view
    }(UIView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()
        setCellHighlighted(false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.kf.cancelDownloadTask()
        photoView.kf.setImage(with: URL(string: ""))
        photoView.image = nil
    }

    func setCard(_ card: CardRepresentable) {
        titleLabel.text = card.title
        titleLabel.setLineHeight(UIDevice.isIpad ? 17:12.1)
        titleLabel.textAlignment = .center

        subtitleLabel.text = card.subtitle
        subtitleLabel.setLineHeight(UIDevice.isIpad ? 17:12.1)
        subtitleLabel.textAlignment = .center

        if let imageURL = card.imageURL {
            photoView.kf.setImage(with: imageURL)
        }
    }

    func setCellHighlighted(_ highlighted: Bool) {
        overlayView.backgroundColor = highlighted ? .blackColor40 : .clear
    }

}

private extension CardPhotoInfoCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let photoBackView = UIView()
        photoBackView.backgroundColor = .backColor
        photoBackView.cornerRadius = UIDevice.isIpad ? 20:10
        photoBackView.addSubviews(photoView, overlayView)
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        let containerView = UIView()
        containerView.backgroundColor = .cardBackColor
        containerView.cornerRadius = UIDevice.isIpad ? 20:10
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.addSubviews(photoBackView)
        photoBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
}
