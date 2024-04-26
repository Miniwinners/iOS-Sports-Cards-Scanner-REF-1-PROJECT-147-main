import UIKit
import SnapKit

final class IdentifyingCardView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.textColor = .white
        label.font = .font(.ubuntuBold700, size: 24)
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
        label.font = .font(.ubuntuMedium500, size: 24)

        return label
    }(UILabel())

    lazy var cancelButton: UIButton = { button in
        var configuration = button.configuration ?? .bordered()
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .white
        configuration.background.cornerRadius = 10
        configuration.cornerStyle = .fixed
        button.configuration = configuration
        button.setAttributedTitle(
            .init(
                string: L10n.IdentifyingCard.Action.cancel,
                attributes: [.font: UIFont.font(.ubuntuBold700, size: 16)]
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
            $0.top.equalTo(safeAreaLayoutGuide).inset(52)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        addSubview(processLabel)
        processLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }

        addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(42)
            $0.top.equalTo(processLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(30)
        }

        let containerView = UIView()
        containerView.addSubviews(cardImageView, indicatorImageView)
        cardImageView.snp.makeConstraints {
            $0.width.equalTo(142)
            $0.height.equalTo(200)
            $0.top.horizontalEdges.equalToSuperview()
        }
        indicatorImageView.snp.makeConstraints {
            $0.top.equalTo(cardImageView.snp.bottom).offset(20)
            $0.centerX.bottom.equalToSuperview()
        }

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
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
// struct Provider_ViewController: PreviewProvider {
//    static var previews: some View {
//        ContainterView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainterView: UIViewControllerRepresentable {
//        func makeUIViewController(context: Context) -> UIViewController {
//            return viewController
//        }
//
//        typealias UIViewControllerType = UIViewController
//
//        let viewController = IdentifyingCardViewController(scannedCard: ScannedCard(encodedCardImage: dummyData, cardCategory: .basketball))
//        func makeUIViewController(context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) -> IdentifyingCardViewController {
//            return viewController
//        }
//
//        func updateUIViewController(_ uiViewController: Provider_ViewController.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<Provider_ViewController.ContainterView>) {
//
//        }
//    }
// }

struct GreenViewRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> IdentifyingCardView {
        return IdentifyingCardView()
    }

    func updateUIView(_ uiView: IdentifyingCardView, context: Context) {
        // Здесь можно обновлять представление, если это необходимо
    }
}

struct GreenViewPreview: PreviewProvider {
    static var previews: some View {
        GreenViewRepresentable()
//            .frame(width: 100, height: 100, alignment: .center) // Вы можете настроить размеры
//            .previewLayout(.sizeThatFits)
    }
}
