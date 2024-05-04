import UIKit
import SnapKit

final class AddToPortfolioButton: UIButton {

    lazy var addImageView: UIImageView = { image in
        image.image = Images.addToPortfolio.image
        image.backgroundColor = .clear
        return image
    }(UIImageView())

    lazy var titleLabelAdd: UILabel = .init()
    lazy var subTitleLabelAdd: UILabel = .init()

    convenience init() {
        self.init(frame: .zero)
        setup_subviews()
    }

    override func updateConfiguration() {
        switch state {
        case .highlighted:
            backgroundColor = .highlightColor2
        default:
            backgroundColor = .skyBlue
        }
    }

}

private extension AddToPortfolioButton {
    func setup_subviews() {
//        configuration = .plain()
        backgroundColor = .darkBlue
        layer.cornerRadius = 12
        addSubview(addImageView)
        addImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(UIDevice.isIpad ? 50:32)
        }
        addSubview(titleLabelAdd)
        titleLabelAdd.text = L10n.CardDetails.Action.addCard
        titleLabelAdd.textAlignment = .center
        titleLabelAdd.textColor = .white
        titleLabelAdd.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        titleLabelAdd.setLineHeight(UIDevice.isIpad ? 26:22)
        titleLabelAdd.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(addImageView.snp.bottom).offset(UIDevice.isIpad ? 40:30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?20:10)

        }
        addSubview(subTitleLabelAdd)
        subTitleLabelAdd.text = L10n.CardDetails.Action.addCard
        subTitleLabelAdd.textAlignment = .center
        subTitleLabelAdd.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.35)
        subTitleLabelAdd.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 18:12)
        subTitleLabelAdd.setLineHeight(UIDevice.isIpad ? 28:22)
        subTitleLabelAdd.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 15:5)
        }
    }
}
