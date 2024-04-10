import UIKit
import SnapKit

final class OptionsView: UIView {

    var showsShadow: Bool = false
    var animationDuration: Double = 0.25

    var didSelectOption: ((Int) -> Void)?

    private var options: [String] = []

    private let minHeight: CGFloat
    private let maxHeight: CGFloat

    private var isOpened: Bool = false

    private var selfHeightConstraint: Constraint!

    // MARK: - Subviews

    lazy var containerView: UIView = { view in
        view.backgroundColor = .white
        view.cornerRadius = 12
        return view
    }(UIView())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.interRegular, size: 16)
        label.textColor = .labelColor
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = .init(image: Images.disclosureBottom.image.withTintColor(.labelColor4))

    lazy var discloseButton: CommonButton = .init(style: .custom(buttonAppearance))

    lazy var underlineView: UIView = { view in
        view.backgroundColor = .dividerColor
        view.layer.opacity = 0
        return view
    }(UIView())

    lazy var optionsTableView: UITableView = { tableView in
        tableView.register(OptionTableViewCell.self, forCellReuseIdentifier: OptionTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        return tableView
    }(UITableView())

    init(minHeight: CGFloat, maxHeight: CGFloat) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight

        super.init(frame: .zero)

        setupSubviews_unique()
        setupActions_unique()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setOptionTitle(_ title: String) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        titleLabel.text = title
    }

    func setOptions(_ options: [String]) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        self.options = options
        optionsTableView.reloadData()
    }

    func open() {
        guard !isOpened else { return }
        isOpened = true

        selfHeightConstraint.update(offset: maxHeight)

        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveLinear) {
            if self.showsShadow {
                self.layer.shadowOpacity = 1
            }
            self.disclosureImageView.transform = .init(rotationAngle: .pi)
            self.underlineView.layer.opacity = 1
            self.superview?.layoutIfNeeded()
        }
    }

    func closeOptionsView() {
        guard isOpened else { return }
        isOpened = false

        selfHeightConstraint.update(offset: minHeight)

        let angles: [CGFloat] = [.pi / 2, 0]
        let duration = animationDuration / Double(angles.count)
        for (index, angle) in angles.enumerated() {
            UIView.animate(withDuration: duration, delay: duration * Double(index), options: .curveLinear) {
                self.disclosureImageView.transform = .init(rotationAngle: angle)
            }
        }

        UIView.animate(withDuration: animationDuration) {
            self.underlineView.layer.opacity = 0
            self.layer.shadowOpacity = 0
            self.superview?.layoutIfNeeded()
        } completion: { _ in
            if self.options.isEmpty { return }
            self.optionsTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

private extension OptionsView {
    var buttonAppearance: CommonButton.SCSAppearance {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 0
        return .init(
            configuration: configuration,
            backgroundColors: .init(primary: .white, disabled: .secondaryColor, highlighted: .highlightColor2)
        )
    }

    func setupSubviews_unique() {
        cornerRadius = 12
        clipsToBounds = false
        layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 0.25)
        layer.shadowOpacity = 0
        layer.shadowRadius = 19
        layer.shadowOffset = .init(width: 0, height: 4)

        snp.makeConstraints {
            selfHeightConstraint = $0.height.equalTo(0).offset(minHeight).constraint
        }

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.addSubviews(discloseButton, underlineView, optionsTableView)
        discloseButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(minHeight)
        }
        underlineView.snp.makeConstraints {
            $0.top.equalTo(discloseButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        optionsTableView.snp.makeConstraints {
            $0.top.equalTo(underlineView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview().priority(.high)
        }

        discloseButton.addSubviews(titleLabel, disclosureImageView)
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        disclosureImageView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(16)
            $0.height.equalTo(9)
        }
    }

    func setupActions_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        discloseButton.addTarget(self, action: #selector(discloseTapped), for: .touchUpInside)
    }

    func option(at indexPath: IndexPath) -> String? {
        options[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func discloseTapped() {
        if isOpened {
            closeOptionsView()
        } else {
            open()
        }
    }
}

// MARK: - TableView DataSource

extension OptionsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionTableViewCell.className, for: indexPath) as? OptionTableViewCell

        if let option = option(at: indexPath) {
            cell?.setCellTitle(option)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: options))

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension OptionsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectOption?(indexPath.row)
        closeOptionsView()
    }
}
