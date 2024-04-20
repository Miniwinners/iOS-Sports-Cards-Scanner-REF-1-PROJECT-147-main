import UIKit
import SnapKit
import Kingfisher

final class SwipeableCardButton: UIButton {

    static let photoRatio: CGFloat = 235 / 330

    lazy var photoContainerView: UIView = { view in
        view.cornerRadius = 20
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        return view
    }(UIView())

    lazy var cardPhotoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var overlayView: UIView = { view in
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }(UIView())

    lazy var cardTitleLabel: UILabel = { label in
        label.font = .font(.ubuntuBold700, size: 24)
        label.textColor = .black
        return label
    }(UILabel())

    lazy var cardSubtitleLabel: UILabel = { label in
        label.font = .font(.ubuntuRegular400, size: 16)
        label.textColor = .black
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
        configuration.baseBackgroundColor = .clear
        configuration.background.backgroundColorTransformer = .init({ _ in .clear })
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

        addSubviews(cardTitleLabel, cardSubtitleLabel, photoContainerView)
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        cardSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardTitleLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        photoContainerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(cardSubtitleLabel.snp.bottom).offset(15)
            $0.width.equalTo(cardPhotoView.snp.height).multipliedBy(Self.photoRatio)
        }

    }
}
