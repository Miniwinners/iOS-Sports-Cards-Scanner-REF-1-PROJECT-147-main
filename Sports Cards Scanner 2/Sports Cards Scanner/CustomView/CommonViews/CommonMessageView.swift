import UIKit
import SnapKit

final class CommonMessageView: UIView {

    lazy var cardImage: UIImageView = .init(image: Images.cardNocards.image)

    lazy var titleLabel: UILabel = { label in
        label.textColor = .singINLabel
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)
        label.numberOfLines = 0
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setMessageTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.setLineHeight(UIDevice.isIpad ?30:24)
        titleLabel.textAlignment = .center
    }

    private func setupSubviews_unique() {
        backgroundColor = .clear
        addSubview(cardImage)
        cardImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(UIDevice.isIpad ? 55:32)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(cardImage.snp.bottom).offset(UIDevice.isIpad ? 20:15)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }

}
