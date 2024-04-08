import UIKit
import SnapKit
import Kingfisher

final class SwipeableCardButton: UIButton {

    static let photoRatio: CGFloat = 235 / 330

    lazy var photoContainerView: UIView = { view in
        view.cornerRadius = 20
        view.backgroundColor = .backColor
        view.isUserInteractionEnabled = false
        return view
    }(UIView())

    lazy var cardPhotoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var overlayView: UIView = { view in
        view.backgroundColor = .blackColor40
        view.isHidden = true
        return view
    }(UIView())

    lazy var cardTitleLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .white
        return label
    }(UILabel())

    lazy var cardSubtitleLabel: UILabel = { label in
        label.font = .font(.interMedium, size: 16)
        label.textColor = .white
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupConfiguration()
        setupSubviews_unique()
    }

    override func updateConfiguration() {
        switch state {
        case .highlighted:
            overlayView.isHidden = false
        default:
            overlayView.isHidden = true
        }
    }

    func setCard(_ card: CardRepresentable?) {
        cardPhotoView.kf.cancelDownloadTask()
        cardPhotoView.kf.setImage(with: URL(string: ""))
        cardPhotoView.image = nil

        if let imageURL = card?.imageURL {
            cardPhotoView.kf.setImage(with: imageURL)
        }

        cardTitleLabel.text = card?.title
        cardTitleLabel.setLineHeight(19)
        cardTitleLabel.textAlignment = .center

        cardSubtitleLabel.text = card?.subtitle
        cardSubtitleLabel.setLineHeight(19)
        cardSubtitleLabel.textAlignment = .center
    }

}

private extension SwipeableCardButton {
    func setupConfiguration() {
        var configuration: UIButton.Configuration = .filled()
        configuration.baseBackgroundColor = .cardBackColor
        configuration.background.backgroundColorTransformer = .init({ _ in .cardBackColor })
        configuration.background.cornerRadius = 24
        configuration.cornerStyle = .fixed
        self.configuration = configuration
    }

    func setupSubviews_unique() {
        photoContainerView.addSubviews(cardPhotoView, overlayView)
        cardPhotoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubviews(photoContainerView, cardTitleLabel, cardSubtitleLabel)
        photoContainerView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(12)
            $0.width.equalTo(cardPhotoView.snp.height).multipliedBy(Self.photoRatio)
        }
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardPhotoView.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        cardSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardTitleLabel.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
    }
}
