import UIKit
import SnapKit

final class GradeSelectionView: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var graderOptionsView: OptionsView = .init(minHeight: 46, maxHeight: 228)
    lazy var gradeOptionsView: OptionsView = .init(minHeight: 46, maxHeight: 228)

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
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        gradeOptionsView.snp.makeConstraints {
            $0.top.equalTo(graderOptionsView.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        bringSubviewToFront(graderOptionsView)
        backView.addSubview(updateDetailsButton)
        updateDetailsButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
    }
}
