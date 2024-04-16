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
            backgroundColor = .blue
        }
    }

}

private extension AddToPortfolioButton {
    func setup_subviews() {
        backgroundColor = .blue
        layer.cornerRadius = 12
        addSubview(addImageView)
        addImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(32)
        }
        addSubview(titleLabelAdd)
        titleLabelAdd.text = L10n.CardDetails.Action.addCard
        titleLabelAdd.textColor = .white
        titleLabelAdd.font = .font(.ubuntuMedium500, size: 16)
        titleLabelAdd.setLineHeight(22)
        titleLabelAdd.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(addImageView.snp.bottom).offset(30)
            $0.horizontalEdges.equalToSuperview().inset(10)

        }
        addSubview(subTitleLabelAdd)
        subTitleLabelAdd.text = L10n.CardDetails.Action.addCard
        subTitleLabelAdd.textColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.35)
        subTitleLabelAdd.font = .font(.ubuntuMedium500, size: 12)
        subTitleLabelAdd.setLineHeight(22)
        subTitleLabelAdd.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
}
