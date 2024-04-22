import UIKit
import SnapKit

extension EditCardView {
    final class DetailView: UIView {
        lazy var nameLabel: UILabel = .init()
        lazy var descriptionLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: Images.forwardArrowBlue.image)

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
    }

    func setDetailDescription(_ description: String?) {
        descriptionLabel.text = description
        descriptionLabel.isHidden = description.isNil
    }

    private func setupSubviews_unique() {
        let containerView = UIView()
        let containerViewTwo = UIView()
        containerView.addSubview(nameLabel)
        containerViewTwo.addSubview(descriptionLabel)
        backgroundColor = .clear
        layer.cornerRadius = 16
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 1
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = .font(.ubuntuMedium500, size: 16)

        descriptionLabel.textColor = .singINLabel
        descriptionLabel.font = .font(.ubuntuRegular400, size: 14)
        descriptionLabel.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [containerView, containerViewTwo])
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        addSubviews(stackView, discloseImageView)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(18)
            make.edges.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
            make.height.equalTo(18)
        }
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(42)
        }
        discloseImageView.snp.makeConstraints {
            $0.size.equalTo(32)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(20)
        }
    }
}
