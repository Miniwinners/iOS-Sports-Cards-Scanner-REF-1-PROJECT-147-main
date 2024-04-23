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
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2

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
//            make.horizontalEdges.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.top.equalToSuperview().inset(42)
        }
    }

}
class BackView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewAppearance()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewAppearance() {
        backgroundColor = .white
        layer.cornerRadius = 24
    }

    func setupView(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

class DoneButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupButton() {
        backgroundColor = .clear
        setTitle("Done", for: .normal)
        titleLabel?.font = .font(.ubuntuMedium500, size: 16)
        titleLabel?.textColor = .black
        setTitleColor(.black, for: .normal)

    }

    func setInView(_ view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.right.equalToSuperview().inset(20)
            make.height.equalTo(22)
            make.width.equalTo(40)
        }
    }

}
