import UIKit
import SnapKit

final class IdentifyingCardView: UIView {

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

    lazy var indicatorImageView: UIImageView = .init(image: Images.loadingIndicator.image)

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
        setupSubviews_unique()
        animateIndicator()
    }

}

private extension IdentifyingCardView {
    func setupSubviews_unique() {
        backgroundColor = .darkBackColor

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:52)
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

    func animateIndicator() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
            self.indicatorImageView.transform = self.indicatorImageView.transform.rotated(by: .pi)
        } completion: { _ in
            self.animateIndicator()
        }
    }
}

 import SwiftUI

 struct CardDetailsViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> IdentifyingCardView {
        // Create and return an instance of your custom UIView here
        return IdentifyingCardView()
    }

    func updateUIView(_ uiView: IdentifyingCardView, context: Context) {
        // Update the view when your app's state changes
    }
 }

 struct ContentView: View {
    var body: some View {
        CardDetailsViewRepresentable()
    }
 }

 @available(iOS 13.0, *)
 struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
 }
