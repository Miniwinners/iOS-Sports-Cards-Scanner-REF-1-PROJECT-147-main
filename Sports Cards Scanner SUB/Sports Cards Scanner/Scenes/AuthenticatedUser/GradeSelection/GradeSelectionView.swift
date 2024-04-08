import UIKit
import SnapKit

final class GradeSelectionView: UIView {

    lazy var graderOptionsView: OptionsView = .init(minHeight: 46, maxHeight: 228)
    lazy var gradeOptionsView: OptionsView = .init(minHeight: 46, maxHeight: 228)

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }
}

private extension GradeSelectionView {
    func setupSubviews_unique() {
        backgroundColor = .backColor

        addSubviews(graderOptionsView, gradeOptionsView)
        graderOptionsView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        gradeOptionsView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(66)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        bringSubviewToFront(graderOptionsView)
    }
}
