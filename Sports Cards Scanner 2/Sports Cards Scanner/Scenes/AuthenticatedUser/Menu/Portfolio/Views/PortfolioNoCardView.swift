import UIKit
import SnapKit

final class PortfolioNoCardView: UIView {

    lazy var illustrationView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var scanImageView: UIImageView = .init(image: Images.scannerApp.image)

    lazy var scanInstructionsView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var scanInstructionsLabel: UILabel = { label in
        label.text = L10n.Portfolio.scanInstructions
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

private extension PortfolioNoCardView {
    func setupSubviews_unique() {
        addSubview(illustrationView)
        illustrationView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        illustrationView.addSubview(scanImageView)
        scanImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(60)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(140)
        }

        addSubview(scanInstructionsView)
        scanInstructionsView.snp.makeConstraints {
            $0.top.equalTo(illustrationView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        scanInstructionsView.addSubview(scanInstructionsLabel)
        scanInstructionsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(43)
            $0.horizontalEdges.equalToSuperview().inset(42)
            $0.bottom.equalToSuperview().inset(35)
        }

        addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints {
            $0.size.equalTo(61)
            $0.top.equalTo(scanInstructionsView.snp.bottom).offset(10)
            $0.bottom.centerX.equalToSuperview()
        }
    }
}
