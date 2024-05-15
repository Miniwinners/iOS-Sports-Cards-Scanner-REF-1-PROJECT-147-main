import UIKit
import SnapKit
func vicheslitFibonc251(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiIdentifyKartiVid: UIView {

    lazy var titleLabel: UILabel = { label in
        label.textColor = .white
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 30:24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var cardImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 20
        return imageView
    }(UIImageView())

    lazy var indicatorImageView: UIImageView = .init(image: SportivinieKartiImages.loadingIndicator.image)

    lazy var processLabel: UILabel = { label in
        label.text = L10n.IdentifyingCard.processTitle
        label.textColor = .white
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 30:24)

        return label
    }(UILabel())

    lazy var cancelButton: UIButton = { button in
        var configuration = button.configuration ?? .bordered()
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .white
        configuration.background.cornerRadius = UIDevice.isIpad ? 16:10
        configuration.cornerStyle = .fixed
        button.configuration = configuration
        button.setAttributedTitle(
            .init(
                string: L10n.IdentifyingCard.Action.cancel,
                attributes: [.font: UIFont.font(.ubuntuBold700, size: UIDevice.isIpad ? 22:16)]
            ),
            for: .normal
        )
        return button
    }(UIButton())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
        animirovatIndicator()
    }

}

private extension SportivinieKartiIdentifyKartiVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .darkBackColor

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 60:40)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80:20)
        }

        let containerView = UIView()
        containerView.addSubviews(cardImageView, indicatorImageView)
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(UIDevice.isIpad ? 284:200)
            $0.height.equalTo(UIDevice.isIpad ? 420:294)
            $0.top.horizontalEdges.equalToSuperview()
        }
        indicatorImageView.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(UIDevice.isIpad ? 50:30)
            $0.size.equalTo(UIDevice.isIpad ? 75:48)
            $0.centerX.bottom.equalToSuperview()
        }

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 60:30)
            $0.centerX.equalToSuperview()
        }

        addSubview(processLabel)
        processLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(containerView.snp.bottom).offset(UIDevice.isIpad ? 40:20)
        }

        addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 66:42)
            $0.top.equalTo(processLabel.snp.bottom).offset(UIDevice.isIpad ? 60:40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIDevice.isIpad ? 240:150)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 50:30)
        }

    }

    func animirovatIndicator() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.indicatorImageView.transform = self.indicatorImageView.transform.rotated(by: .pi)
        } completion: { _ in
            self.animirovatIndicator()
        }
    }
}
