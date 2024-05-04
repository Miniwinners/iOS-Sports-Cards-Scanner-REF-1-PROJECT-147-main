import UIKit
import SnapKit

final class GradeSelectionView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var graderOptionsView: OptionsView = .init(minHeight: UIDevice.isIpad ?80:46, maxHeight: UIDevice.isIpad ?400:254)
    lazy var gradeOptionsView: OptionsView = .init(minHeight: UIDevice.isIpad ?80:46, maxHeight: UIDevice.isIpad ?400:254)

    lazy var updateDetailsButton: CommonButton = { button in
        button.setButtonTitle(L10n.EditCard.Action.updateDetails)
        return button
    }(CommonButton(style: .default))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }
}

private extension GradeSelectionView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        backView.setupView(in: self)
        titleLabel.setupLabel(in: backView)

        backView.addSubviews(graderOptionsView, gradeOptionsView)
        graderOptionsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }
        gradeOptionsView.snp.makeConstraints {
            $0.top.equalTo(graderOptionsView.snp.bottom).offset(UIDevice.isIpad ?20:10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }

        bringSubviewToFront(graderOptionsView)
        backView.addSubview(updateDetailsButton)
        updateDetailsButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ?80:54)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ?60:20)
        }
    }
}
