import UIKit
import SnapKit
import Kingfisher

final class CardPhotoCollectionViewCell: UICollectionViewCell {

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 6
        return imageView
    }(UIImageView())

    lazy var overlayView: UIView = { view in
        view.cornerRadius = 6
        return view
    }(UIView())

    lazy var selectedImageView: UIImageView = .init(image: Images.cardCheck.image)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()
        setCellHighlighted(false)
        setSelected(false)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        setSelected(false)
        setCellHighlighted(false)
    }

    func setCard(_ card: CardRepresentable) {
        guard let imageURL = card.imageURL else { return }
        photoView.kf.setImage(with: imageURL)
    }

    func setSelected(_ selected: Bool) {
        selectedImageView.isHidden = !selected
    }

    func setCellHighlighted(_ highlighted: Bool) {
        overlayView.backgroundColor = highlighted ? .blackColor40 : .clear
    }

}

private extension CardPhotoCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        let backView = UIView()
        backView.backgroundColor = .backColor
        backView.cornerRadius = 6
        contentView.addSubview(backView)
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(overlayView)
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
