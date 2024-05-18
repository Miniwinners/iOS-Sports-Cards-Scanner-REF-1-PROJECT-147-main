import UIKit
import SnapKit
func vicheslitFibon326(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiOptionV: UIView {

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
        view.backgroundColor = .clear

        view.cornerRadius = UIDevice.isIpad ? 20:12
        view.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 4
        view.layer.shadowOffset = .init(width: 0, height: 4)
        return view
    }(UIView())

    lazy var titleLabel: UILabel = { label in
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ?22:16)
        label.textColor = .black
        return label
    }(UILabel())

    lazy var disclosureImageView: UIImageView = .init(image: SportivinieKartiImages.disclosureBottom.image.withTintColor(.black))

    lazy var discloseButton: SportivinieKartiCommonKnopka = .init(style: .custom(buttonAppearance))

    lazy var optionsTableView: UITableView = { tableView in
        tableView.register(SportivinieKartiOptionTableKlrtka.self, forCellReuseIdentifier: SportivinieKartiOptionTableKlrtka.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        tableView.estimatedRowHeight = UIDevice.isIpad ?80:50
        tableView.layer.cornerRadius = UIDevice.isIpad ?20:12
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor(red: 0, green: 0, blue: 255/255, alpha: 0.1)
//        tableView.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
//        tableView.layer.shadowOpacity = 1
//        tableView.layer.shadowRadius = 4
//        tableView.layer.shadowOffset = .init(width: 0, height: 4)
        return tableView
    }(UITableView())

    init(minHeight: CGFloat, maxHeight: CGFloat) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight

        super.init(frame: .zero)

        postavitVidunicalno()
        postavidDeistviaUnicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func zagolovokOpcii(_ title: String) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = title
    }

    func postavitOpcii(_ options: [String]) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        self.options = options
        optionsTableView.reloadData()
    }

    func otrkit() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard !isOpened else { return }
        isOpened = true
        selfHeightConstraint.update(offset: maxHeight)
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveLinear) {
            if self.showsShadow {
                self.containerView.layer.shadowOpacity = 0.3
                self.layer.masksToBounds = false
                self.clipsToBounds = false
                self.containerView.layer.masksToBounds = false
                self.containerView.clipsToBounds = false
            }
            self.disclosureImageView.transform = .init(rotationAngle: .pi)

            self.superview?.layoutIfNeeded()
        }
    }

    func zakritVidOpcii() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
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
            self.containerView.layer.shadowOpacity = 0
            self.superview?.layoutIfNeeded()
        } completion: { _ in
            if self.options.isEmpty { return }
            self.optionsTableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

private extension SportivinieKartiOptionV {
    var buttonAppearance: SportivinieKartiCommonKnopka.SportivinieKartiVidKnopki {
        var configuration: UIButton.Configuration = .filled()
        configuration.cornerStyle = .fixed
        configuration.background.cornerRadius = 12
        return .init(
            configuration: configuration,
            backgroundColors: .init(primary: .skyBlue, disabled: .secondaryColor, highlighted: .highlightColor2)
        )
    }

    func postavitVidunicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cornerRadius = 12
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 4
//        layer.shadowOffset = .init(width: 0, height: 4)

        snp.makeConstraints {
            selfHeightConstraint = $0.height.equalTo(0).offset(minHeight).constraint
        }

        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        containerView.addSubviews(discloseButton, optionsTableView)

        discloseButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(minHeight)
        }

        optionsTableView.snp.makeConstraints {
            $0.top.equalTo(discloseButton.snp.bottom).offset(8)
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

    func postavidDeistviaUnicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        discloseButton.addTarget(self, action: #selector(disclosezakrtiNazhata), for: .touchUpInside)
    }

    func opcii(at indexPath: IndexPath) -> String? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return options[safe: indexPath.row]
    }

    // MARK: - Actions

    @objc func disclosezakrtiNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if isOpened {
            zakritVidOpcii()
        } else {
            otrkit()
        }
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiOptionV: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let cell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiOptionTableKlrtka.className, for: indexPath) as? SportivinieKartiOptionTableKlrtka

        if let option = opcii(at: indexPath) {
            cell?.postavitCellZagolovok(option)
        }

        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return UIDevice.isIpad ? 80:50
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiOptionV: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectOption?(indexPath.row)
        zakritVidOpcii()
    }
}
