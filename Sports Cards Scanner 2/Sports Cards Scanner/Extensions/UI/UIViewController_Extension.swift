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

    init(style: ButtonFunc, frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupButton(style: style)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton(style: ButtonFunc) {
        setImage(Images.close.image, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = UIDevice.isIpad ? 30 : 22
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2

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
            make.size.equalTo(UIDevice.isIpad ? 60 : 44)
        }
    }

    func setLeft(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(UIDevice.isIpad ? 60 : 44)
            make.left.equalToSuperview().inset(UIDevice.isIpad ? 32 : 16)
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
        setSize(fontS: .ubuntuBold700, phone: 22, iPad: 28)
        textAlignment = .center
    }

    func setupLabel(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(UIDevice.isIpad ? 40 : 28)
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 70 : 40)
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
        layer.cornerRadius = UIDevice.isIpad ? 30 : 24
    }

    func setupView(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 30 : 22)
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
        titleLabel?.setSize(fontS: .ubuntuMedium500, phone: 16, iPad: 22)
        titleLabel?.textColor = .black
        setTitleColor(.black, for: .normal)

    }

    func setInView(_ view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 65 : 35)
            make.right.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
            make.height.equalTo(UIDevice.isIpad ? 26 : 22)
            make.width.equalTo(UIDevice.isIpad ? 70 : 40)
        }
    }

}
