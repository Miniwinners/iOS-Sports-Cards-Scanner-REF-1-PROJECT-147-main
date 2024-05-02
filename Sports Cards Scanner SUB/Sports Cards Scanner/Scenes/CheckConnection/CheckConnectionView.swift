import SnapKit
import UIKit

class CheckConnectionView: UIView {

    lazy var progressLabel: UILabel = { label in
        label.textColor = .blue
        label.font = .font(.interSemibold, size: UIDevice.isIpad ? 26:20)
        return label
    }(UILabel())

    lazy var progressBarContainer: UIView = { view in
        view.backgroundColor = .white
        view.borderColor = .blue
        view.borderWidth = 3
        view.layer.cornerRadius = UIDevice.isIpad ? 18:10
        return view
    }(UIView())

    lazy var progressBar: UIProgressView = { bar in
        bar.progressViewStyle = .bar
        bar.tintColor = .blue
        bar.trackTintColor = .clear
        bar.cornerRadius = UIDevice.isIpad ? 12:5
        return bar
    }(UIProgressView())

    lazy var stackView: UIStackView = { stack in
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.spacing = UIDevice.isIpad ? 30:15
        return stack
    }(UIStackView(arrangedSubviews: [imageContainer, titleLabel, buttonConnection]))

    lazy var titleLabel: UILabel = { label in
        label.textColor = .black
        label.text = "No Internet"
        label.textAlignment = .center
        label.font = .font(.interMedium, size: UIDevice.isIpad ? 24:18)
        return label
    }(UILabel())

    lazy var buttonConnection: CommonButton = { button in
        button.setButtonTitle("OK")
        return button
    }(CommonButton(style: .default))

    lazy var imageContainer: UIView = { view in
        view.borderColor = .black
        view.borderWidth = 2
        view.layer.cornerRadius = UIDevice.isIpad ? 24:12
        return view
    }(UIView())
    lazy var connectionImage: UIImageView = .init(image: Images.noConnection.image)

    convenience init() {
        self.init(frame: .zero)
        setupSubviews()
        stackView.isHidden = true
    }

    func progressPercent(text: String) {
        progressLabel.text = text
    }

}

private extension CheckConnectionView {
    func setupSubviews() {
        backgroundColor = .white

        addSubview(progressBarContainer)
        progressBarContainer.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ? 70:30)
            make.width.equalTo(UIDevice.isIpad ? 406:206)
            make.height.equalTo(UIDevice.isIpad ? 60:40)
            make.centerX.equalToSuperview()
        }

        progressBarContainer.addSubview(progressBar)
        progressBar.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(7)
        }
        addSubview(progressLabel)

        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(UIDevice.isIpad ? 20:10)
            make.height.equalTo(UIDevice.isIpad ? 30:20)
            make.centerX.equalToSuperview()
        }

        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(UIDevice.isIpad ? 192:120)
            make.center.equalToSuperview()
        }
        imageContainer.snp.makeConstraints { make in
            make.height.equalTo(192)
        }
        imageContainer.addSubview(connectionImage)
        connectionImage.snp.makeConstraints { make in
            make.size.equalTo(UIDevice.isIpad ? 76:48)
            make.center.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ? 30:20)
        }
        buttonConnection.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ? 60:40)
        }

    }
}
