import UIKit
import SnapKit

extension EditCardView {
    final class DetailView: UIView {
        lazy var nameLabel: UILabel = .init()
        lazy var descriptionLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: Images.forwardArrow.image)

        convenience init() {
            self.init(frame: .zero)
            setupSubviews_unique()
        }
    }
}

extension EditCardView.DetailView {
    func setDetailName(_ name: String?) {
        nameLabel.text = name
        nameLabel.isHidden = name.isNil
        nameLabel.setLineHeight(22)
    }

    func setDetailDescription(_ description: String?) {
        descriptionLabel.text = description
        descriptionLabel.isHidden = description.isNil
        descriptionLabel.setLineHeight(22)
    }

    private func setupSubviews_unique() {
        backgroundColor = .clear

        nameLabel.textColor = .labelColor
        nameLabel.font = .font(.interMedium, size: 16)

        descriptionLabel.textColor = .labelColor
        descriptionLabel.font = .font(.interRegular, size: 14)

        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 2

        addSubviews(stackView, discloseImageView)
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        discloseImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
