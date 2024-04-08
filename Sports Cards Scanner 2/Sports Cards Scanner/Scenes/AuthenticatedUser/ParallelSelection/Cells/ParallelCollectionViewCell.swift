import UIKit
import SnapKit
import Kingfisher

final class ParallelCollectionViewCell: UICollectionViewCell {

    lazy var imageContainerView: UIView = { view in
        view.backgroundColor = .cardBackColor
        view.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }(UIView())

    lazy var parallelImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var missingImageLabel: UILabel = { label in
        label.text = L10n.ParallelSelection.missingSample
        label.textColor = .white
        label.font = .font(.interRegular, size: 12)
        label.numberOfLines = 2
        label.setLineHeight(22)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var overlayView: UIView = { view in
        view.backgroundColor = .blackColor40
        view.isHidden = true
        return view
    }(UIView())

    lazy var selectedImageView: UIImageView = .init(image: Images.cardCheck.image)

    lazy var nameLabel: UILabel = { label in
        label.textColor = .black
        label.font = .font(.interMedium, size: 14)
        label.textAlignment = .center
        return label
    }(UILabel())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        parallelImageView.kf.cancelDownloadTask()
        parallelImageView.kf.setImage(with: URL(string: ""))
        parallelImageView.image = nil
    }

    func setParallel(_ parallel: CardParallel) {
        nameLabel.text = parallel.name

        parallelImageView.kf.setImage(with: parallel.imageURL)
        missingImageLabel.isHidden = parallel.imageURL.isNotNil
    }

    func setParallelSelected(_ selected: Bool) {
        selectedImageView.isHidden = !selected
    }

    func setCellHighlighted(_ highlighted: Bool) {
        overlayView.isHidden = !highlighted
    }

}

private extension ParallelCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        imageContainerView.addSubviews(missingImageLabel, parallelImageView, overlayView, selectedImageView)
        missingImageLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(6)
            $0.bottom.equalToSuperview().inset(10)
        }
        parallelImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        selectedImageView.snp.makeConstraints {
            $0.size.equalTo(38)
            $0.center.equalToSuperview()
        }

        contentView.addSubviews(imageContainerView, nameLabel)
        imageContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageContainerView.snp.width)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageContainerView.snp.bottom).offset(6)
            $0.horizontalEdges.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview()
        }
    }
}
