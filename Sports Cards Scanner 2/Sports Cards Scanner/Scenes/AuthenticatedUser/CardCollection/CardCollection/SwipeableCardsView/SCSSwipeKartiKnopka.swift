import UIKit
import SnapKit
import Kingfisher
func vicheslitFibonc190(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSwipeKartiKnopka: UIButton {

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
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 30:22)
        label.numberOfLines = 2

        label.textColor = .black
        return label
    }(UILabel())

    lazy var cardSubtitleLabel: UILabel = { label in
        label.numberOfLines = 2
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22:16)
        label.textColor = .black
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        podgotovitKonfiguraciu()
        postavitVidunicalno()
    }

    override func updateConfiguration() {
        switch state {
        case .highlighted:
            overlayView.isHidden = false
        default:
            overlayView.isHidden = true
        }
    }

    func postavitKarty(_ card: SportivinieKartiKartaPredstavlenie?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardPhotoView.kf.cancelDownloadTask()
        cardPhotoView.kf.setImage(with: URL(string: ""))
        cardPhotoView.image = nil

        if let imageURL = card?.imageURL {
            cardPhotoView.kf.setImage(with: imageURL)
        }

        cardTitleLabel.text = card?.title
        cardTitleLabel.textAlignment = .center
        cardTitleLabel.numberOfLines = 2
        cardSubtitleLabel.text = card?.subtitle
        cardSubtitleLabel.textAlignment = .center
        cardSubtitleLabel.numberOfLines = 2
    }

}

private extension SportivinieKartiSwipeKartiKnopka {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func podgotovitKonfiguraciu() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        var configuration: UIButton.Configuration = .filled()
        configuration.baseBackgroundColor = .clear
        configuration.background.backgroundColorTransformer = .init({ _ in .clear })
        configuration.background.cornerRadius = 24
        configuration.cornerStyle = .fixed
        self.configuration = configuration
    }

    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        photoContainerView.addSubviews(cardPhotoView, overlayView)
        cardPhotoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addSubviews(cardTitleLabel, cardSubtitleLabel, photoContainerView)
        cardTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.lessThanOrEqualTo(UIDevice.isIpad ? 60:50)
            $0.horizontalEdges.equalToSuperview()
        }
        cardSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(cardTitleLabel.snp.bottom).offset(5)
            $0.height.lessThanOrEqualTo(UIDevice.isIpad ? 50:40)
            $0.horizontalEdges.equalToSuperview()
        }
        photoContainerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(cardSubtitleLabel.snp.bottom).offset(5)
            $0.width.equalTo(cardPhotoView.snp.height).multipliedBy(Self.photoRatio)
        }

    }
}
