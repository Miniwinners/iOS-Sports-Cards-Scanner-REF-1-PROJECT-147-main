import UIKit
import SnapKit

final class CommonMessageView: UIView {

    lazy var titleLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.interRegular, size: 20)
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
        backgroundColor = .white
        cornerRadius = 12

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(16)
        }
    }

}
