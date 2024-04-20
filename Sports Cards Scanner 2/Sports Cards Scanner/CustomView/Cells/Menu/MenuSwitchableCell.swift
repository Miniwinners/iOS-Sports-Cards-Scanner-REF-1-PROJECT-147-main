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
        switchView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.equalTo(31)
            $0.width.equalTo(48)
            $0.top.equalToSuperview().inset(20)
        }
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(20)
            $0.horizontalEdges.equalToSuperview()
        }

    }
}
