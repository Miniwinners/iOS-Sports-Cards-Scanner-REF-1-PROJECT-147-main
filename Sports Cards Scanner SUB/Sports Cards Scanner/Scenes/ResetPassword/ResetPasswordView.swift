import UIKit
import SnapKit

final class ResetPasswordView: UIView {

    lazy var containerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var emailSendLabel: UILabel = { label in
        label.textColor = .labelColor
        label.font = .font(.interRegular, size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

}

private extension ResetPasswordView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        containerView.addSubview(emailSendLabel)
        emailSendLabel.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.verticalEdges.equalToSuperview().inset(20)
        }
    }
}
