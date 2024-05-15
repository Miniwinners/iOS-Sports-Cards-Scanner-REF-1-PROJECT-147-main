import UIKit
import SnapKit

func vicheslitFibonc97(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartiUIViewCr = UIViewController

extension SportivinieKartiUIViewCr {
    var isViewVisible: Bool {
        viewIfLoaded?.window != nil
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
        setImage(SportivinieKartiImages.close.image, for: .normal)
        backgroundColor = .white
        layer.cornerRadius = UIDevice.isIpad ? 30 : 22
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2

        switch style {
        case .back:
            setImage(SportivinieKartiImages.backArrow.image, for: .normal)
        case .close:
            setImage(SportivinieKartiImages.clear.image, for: .normal)
        }
    }

    func setCenter(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
            make.size.equalTo(UIDevice.isIpad ? 60 : 44)
        }
    }

    func setLeft(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.size.equalTo(UIDevice.isIpad ? 60 : 44)
            make.left.equalToSuperview().inset(UIDevice.isIpad ? 32 : 16)
        }
    }
}

class TitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sdelatVneshniiVid()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func sdelatVneshniiVid() {
        textColor = .logInLabel
        postavitRazmer(fontS: .ubuntuBold700, phone: 22, iPad: 28)
        textAlignment = .center
    }

    func postavitLabel(in view: UIView) {
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
        sdelatVid()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func sdelatVid() {
        backgroundColor = .white
        self.zakruglitYgli([.topRight, .topLeft], radius: UIDevice.isIpad ? 30 : 24)
//        layer.cornerRadius = UIDevice.isIpad ? 30 : 24
    }

    func postavitVid(in view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 40 : 30)
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
        titleLabel?.postavitRazmer(fontS: .ubuntuMedium500, phone: 16, iPad: 22)
        titleLabel?.textColor = .black
        setTitleColor(.black, for: .normal)

    }

    func setInView(_ view: UIView) {
        view.addSubview(self)
        self.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 75 : 45)
            make.right.equalToSuperview().inset(UIDevice.isIpad ? 80 : 20)
            make.height.equalTo(UIDevice.isIpad ? 26 : 22)
            make.width.equalTo(UIDevice.isIpad ? 70 : 40)
        }
    }

}
