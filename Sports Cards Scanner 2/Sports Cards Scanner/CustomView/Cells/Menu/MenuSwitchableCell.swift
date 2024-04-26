import UIKit
import SnapKit

final class MenuSwitchableCell: SwitchableCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMenuItem(_ menuItem: MenuItem, selected: Bool) {
        titleLabel.text = menuItem.localizable
        switchView.setOn(selected, animated: false)
    }

}

private extension MenuSwitchableCell {
    func setupSubviews_unique() {
//        switchView.snp.removeConstraints()
//        titleLabel.snp.removeConstraints()
        switchView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ? 52:32)
            $0.width.equalTo(UIDevice.isIpad ? 81:48)
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 60:20)
        }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(UIDevice.isIpad ?30:20)
        }
        layoutIfNeeded()
    }
}
