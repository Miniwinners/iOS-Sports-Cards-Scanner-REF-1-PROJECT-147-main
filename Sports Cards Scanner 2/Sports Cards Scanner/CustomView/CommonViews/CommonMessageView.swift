import UIKit
import SnapKit

final class CommonMessageView: UIView {

    lazy var cardImage: UIImageView = .init(image: Images.cardNocards.image)

    lazy var titleLabel: UILabel = { label in
        label.textColor = .singINLabel
        label.font = .font(.ubuntuLight300, size: 16)
        label.numberOfLines = 0
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setMessageTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.setLineHeight(24)
        titleLabel.textAlignment = .center
    }

    private func setupSubviews_unique() {
        backgroundColor = .clear
//        cornerRadius = 12
        addSubview(cardImage)
        cardImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(32)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(cardImage.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }

}
