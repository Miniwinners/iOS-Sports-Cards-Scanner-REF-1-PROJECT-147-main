import UIKit
import SnapKit

final class DashboardNoCardView: UIView {

    lazy var welcomeView: UIView = { view in
        return view
    }(UIView())

    lazy var welcomeTextView: UIView = { view in
        return view
    }(UIView())

    lazy var welcomeTitleLabel: UILabel = { label in
        label.text = L10n.Dashboard.Welcome.title
        label.textColor = .black
        label.font = .font(.ubuntuBold700, size: UIDevice.isIpad ? 34 : 28)
        label.setLineHeight(UIDevice.isIpad ?  36 : 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var scanImageView: UIImageView = .init(image: Images.scannerApp.image)

    lazy var welcomeDescriptionLabel: UILabel = { label in
        label.text = L10n.Dashboard.Welcome.description
        label.textColor = .singINLabel
        label.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22 : 16)
        label.setLineHeight(UIDevice.isIpad ? 24: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var instructionsView: UIView = { view in
        view.backgroundColor = .clear
        return view
    }(UIView())

    lazy var scanInstructionsLabel: UILabel = { label in
        label.text = L10n.Dashboard.scanInstructions
        label.textColor = .singINLabel
        label.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 22 : 16)
        label.setLineHeight(UIDevice.isIpad ? 24 : 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
        backgroundColor = .skyBlue
    }

}

private extension DashboardNoCardView {
    func setupSubviews_unique() {

        let innerView = UIView()
        welcomeView.addSubviews(welcomeTitleLabel, scanImageView, welcomeDescriptionLabel)
        welcomeTitleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 :20)
            $0.top.equalTo(scanImageView.snp.bottom).offset(UIDevice.isIpad ? 30 :20)
        }
        scanImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 :20)
        }
        welcomeDescriptionLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(welcomeTitleLabel.snp.bottom).offset(UIDevice.isIpad ? 30 : 20)
            $0.top.lessThanOrEqualTo(welcomeTitleLabel.snp.bottom).offset(UIDevice.isIpad ? 50 : 40)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?  80 :20)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 30 : 10)
        }
        welcomeView.addSubview(innerView)

        addSubviews(welcomeView)
        welcomeView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(UIDevice.isIpad ? 40 : 20)
            $0.top.lessThanOrEqualTo(UIDevice.isIpad ? 52 : 32)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
        }
        addSubview(instructionsView)
        instructionsView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 1000 : 600)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 80 :20)
        }
        instructionsView.addSubview(scanInstructionsLabel)

        scanInstructionsLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
