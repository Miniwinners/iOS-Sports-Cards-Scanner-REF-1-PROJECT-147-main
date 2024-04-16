import UIKit
import SnapKit

final class GraderTableViewCell: UITableViewCell {

    lazy var graderLabel: UILabel = { label in
        label.textColor = .logInLabel
        label.font = .font(.ubuntuRegular400, size: 16)
        label.setLineHeight(22)
        return label
    }(UILabel())

    lazy var separatorView: UIView = { view in
        view.backgroundColor = .dividerColor
        return view
    }(UIView())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setGrader(_ grader: CardGrader) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        graderLabel.text = grader.rawValue
    }

    func setCellPosition(_ position: CellPosition) {
        separatorView.isHidden = position.containsPosition(.atBottomPosition)

        var corners = UIRectCorner()
        if position.containsPosition(.onTopPosition) { corners.insert([.topLeft, .topRight]) }
        if position.containsPosition(.atBottomPosition) { corners.insert([.bottomLeft, .bottomRight]) }
        backgroundView?.subviews.first?.roundCorners(corners, radius: 14)
        selectedBackgroundView?.subviews.first?.roundCorners(corners, radius: 14)
    }

}

private extension GraderTableViewCell {
    func setupSubviews_unique() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundView = createBackgroundView()
        selectedBackgroundView = createHighlightedView()

        contentView.addSubview(graderLabel)
        graderLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(10)
        }

        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(0.5)
        }
    }

    func createBackgroundView() -> UIView {
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20).priority(.high)
        }

        return backgroundContainerView
    }

    func createHighlightedView() -> UIView {
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return highlightedContainerView
    }
}
