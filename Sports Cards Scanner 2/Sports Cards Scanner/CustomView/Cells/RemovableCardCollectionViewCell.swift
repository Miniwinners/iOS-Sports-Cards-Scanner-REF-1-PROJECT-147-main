import UIKit
import SnapKit
import Kingfisher

final class RemovableCardCollectionViewCell: UICollectionViewCell {

    var removeCardDidTap: ((CardRepresentable) -> Void)?

    private var card: CardRepresentable?

    // MARK: - Subviews

    lazy var photoView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.cornerRadius = 6
        return imageView
    }(UIImageView())

    lazy var removeButton: UIButton = { button in
        button.setImage(Images.remove.image, for: .normal)
        return button
    }(UIButton(type: .system))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()
        setupActions_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoView.kf.cancelDownloadTask()
        photoView.kf.setImage(with: URL(string: ""))
        photoView.image = nil
        card = nil
    }

    func setCard(_ card: CardRepresentable) {
        self.card = card
        if let imageURL = card.imageURL {
            photoView.kf.setImage(with: imageURL)
        }
    }
}

private extension RemovableCardCollectionViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        contentView.addSubviews(photoView, removeButton)
        photoView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(6)
            $0.leading.bottom.equalToSuperview()
        }
        removeButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(-13)
            $0.size.equalTo(UIDevice.isIpad ? 80:44)
        }
    }

    func setupActions_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        removeButton.addTarget(self, action: #selector(removeTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc func removeTapped() {
        guard let card = card else { return }
        removeCardDidTap?(card)
    }
}
