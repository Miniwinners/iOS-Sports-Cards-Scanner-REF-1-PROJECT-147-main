import UIKit
import SnapKit

final class DashboardNoCardView: UIView {

    lazy var welcomeView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var welcomeTitleLabel: UILabel = { label in
        label.text = L10n.Dashboard.Welcome.title
        label.textColor = .black
        label.font = .font(.interRegular, size: 20)
        label.setLineHeight(22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var scanImageView: UIImageView = .init(image: Images.scannerApp.image)

    lazy var welcomeDescriptionLabel: UILabel = { label in
        label.text = L10n.Dashboard.Welcome.description
        label.textColor = .black
        label.font = .font(.interRegular, size: 16)
        label.setLineHeight(22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var scanInstructionsView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var scanInstructionsLabel: UILabel = { label in
        label.text = L10n.Dashboard.scanInstructions
        label.textColor = .black
        label.font = .font(.interRegular, size: 20)
        label.setLineHeight(22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var arrowImageView: UIImageView = .init(image: Images.bottomArrow.image)

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

}

private extension DashboardNoCardView {
    func setupSubviews_unique() {
        let innerView = UIView()
        innerView.addSubviews(welcomeTitleLabel, scanImageView, welcomeDescriptionLabel)
        welcomeTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        scanImageView.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(welcomeTitleLabel.snp.bottom).offset(20)
            $0.top.lessThanOrEqualTo(welcomeTitleLabel.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(140)
        }
        welcomeDescriptionLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(scanImageView.snp.bottom).offset(20)
            $0.top.lessThanOrEqualTo(scanImageView.snp.bottom).offset(40)
            $0.bottom.horizontalEdges.equalToSuperview()
        }

        welcomeView.addSubview(innerView)
        innerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(42)

            $0.top.greaterThanOrEqualToSuperview().inset(20)
            $0.top.lessThanOrEqualToSuperview().inset(32)
            $0.bottom.greaterThanOrEqualToSuperview().inset(32)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }

        scanInstructionsView.addSubview(scanInstructionsLabel)
        scanInstructionsLabel.snp.makeConstraints {
            $0.top.greaterThanOrEqualToSuperview().inset(20)
            $0.top.lessThanOrEqualToSuperview().inset(43)
            $0.horizontalEdges.equalToSuperview().inset(42)
            $0.bottom.greaterThanOrEqualToSuperview().inset(35)
            $0.bottom.lessThanOrEqualToSuperview().inset(20)
        }

        addSubviews(welcomeView, scanInstructionsView, arrowImageView)
        welcomeView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        scanInstructionsView.snp.makeConstraints {
            $0.top.equalTo(welcomeView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(61)
            $0.top.equalTo(scanInstructionsView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(84)
        }
    }
}
