import UIKit
import SnapKit
extension UIViewController {
    var isViewVisible: Bool {
        viewIfLoaded?.window != nil
    }

    func setBackButtonImage(_ image: UIImage = Images.backArrow.image.withTintColor(.black)) {
        navigationItem.leftBarButtonItem = .init(
            image: image,
            style: .plain,
            target: self,
            action: #selector(backBarButtonDidTap)
        )
    }

    @objc private func backBarButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

enum ButtonFunc {
    case close
    case back
}

class CloseButton: UIButton {

    // Инициализатор с enum для определения стиля кнопки
    init(style: ButtonFunc, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupButton(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton(style: ButtonFunc) {
        setImage(Images.close.image, for: .normal) // Default image
        backgroundColor = .white
        layer.cornerRadius = 22
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 15

        // Setting image based on the style
        switch style {
        case .back:
            setImage(Images.backArrow.image, for: .normal)
        case .close:
            setImage(Images.clear.image, for: .normal)
        }
    }

    func setCenter(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.size.equalTo(44)
        }
    }

    func setLeft(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(44)
            make.left.equalToSuperview().inset(16)
        }
    }
}

class DeckCollectionView: UIView {

    lazy var previewImage: UIImageView = .init()

    lazy var titleCreate: UILabel = { label in
        label.textColor = .black
        label.font = .font(.ubuntuMedium500, size: 16)
        return label
    }(UILabel())

    lazy var subtitleCreate: UILabel = { label in
        label.textColor = .singINLabel
        label.font = .font(.ubuntuRegular400, size: 12)
        return label
    }(UILabel())
    private lazy var containerView: UIView = .init()
    private lazy var plusImageView: UIImageView = .init(image: Images.addPlus.image)
    private lazy var stackView: UIStackView = .init(arrangedSubviews: [previewImage, titleCreate, subtitleCreate, containerView])

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {

        backgroundColor = .white
        layer.cornerRadius = 16
        addSubview(stackView)
        stackView.backgroundColor = .clear
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.distribution = .fill
        previewImage.contentMode = .scaleAspectFill
        previewImage.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(80)
        }
        plusImageView.backgroundColor = .clear

        containerView.addSubview(plusImageView)
        containerView.snp.makeConstraints { make in
            make.height.lessThanOrEqualTo(33)
        }
        plusImageView.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.center.equalToSuperview()
        }
        titleCreate.setLineHeight(22)
        subtitleCreate.setLineHeight(22)
        containerView.backgroundColor = .skyBlue
        containerView.layer.cornerRadius = 8

        stackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.verticalEdges.equalToSuperview().inset(15)
        }

    }

}

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupAppearance() {
        textColor = .logInLabel
        font = .font(.ubuntuBold700, size: 22)
        textAlignment = .center
    }

    func setupLabel(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.top.equalToSuperview().inset(32)
        }
    }

}
