import UIKit
import SnapKit

final class MenuSelectableCell: SelectableCollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews_unique()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMenuItem(_ item: MenuItem) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        titleLabel.text = item.localizable
        rightImageView.image = item.image
    }
}

private extension MenuSelectableCell {
    func setupSubviews_unique() {
        rightImageView.snp.makeConstraints {
            $0.size.equalTo(31)
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(20)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }

    }
}
