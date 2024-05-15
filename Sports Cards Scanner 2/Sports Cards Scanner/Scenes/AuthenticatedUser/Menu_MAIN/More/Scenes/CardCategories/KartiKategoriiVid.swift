import UIKit
import SnapKit
func vicheslitFibonc227(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartiKategoriiVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()
    let containerView = UIView()
    let containerImage = UIView()

    lazy var descriptionImage: UIImageView = { image in
        image.image = SportivinieKartiImages.deckSign.image
        return image
    }(UIImageView())

    lazy var descriptionLabel: UILabel = { label in
        label.text = L10n.CardCategories.description
        label.postavitRazmer(fontS: .ubuntuLight300, phone: 16, iPad: 24)
        label.textColor = .logInLabel
        label.numberOfLines = 0
        label.setVisotaLabla(UIDevice.isIpad ? 30 : 20)
        label.textAlignment = .center
        return label
    }(UILabel())

    lazy var imageLabelStack: UIStackView = { stackView in
        stackView.spacing = UIDevice.isIpad ? 20:5
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }(UIStackView(arrangedSubviews: [containerImage, descriptionLabel]))

    lazy var checkSignImageView: UIImageView = { image in
        image.image = SportivinieKartiImages.checkSign.image
        return image
    }(UIImageView())

    lazy var tableView: UITableView = { tableView in
        tableView.rowHeight = UIDevice.isIpad ? 80 : 68
        tableView.estimatedRowHeight = UIDevice.isIpad ? 85 : 74
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset.bottom = 20
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .clear
        return tableView
    }(UITableView())

    lazy var minEnabledCategoriesLabel: UILabel = { label in
        label.text = L10n.CardCategories.minEnabledCategories
        label.postavitRazmer(fontS: .ubuntuLight300, phone: 12, iPad: 18)
        label.textColor = .singINLabel
        label.numberOfLines = 1
        label.setVisotaLabla(UIDevice.isIpad ? 20 : 14)
        label.textAlignment = .center
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        backgroundColor = .clear
        postavitVidunicalno()
    }
}

private extension SportivinieKartiKartiKategoriiVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let checkSignView = UIView()

        containerView.backgroundColor = .skyBlue
        containerView.cornerRadius = UIDevice.isIpad ? 24:16

        backView.postavitVid(in: self)
        titleLabel.postavitLabel(in: backView)
        backView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ? 40 : 20)
            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 90 : 20)
            make.height.greaterThanOrEqualTo(UIDevice.isIpad ? 190 : 120)
        }

        containerView.addSubview(imageLabelStack)
        imageLabelStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIDevice.isIpad ? 40 : 20)
        }

        containerImage.snp.makeConstraints { make in
            make.height.equalTo(UIDevice.isIpad ? 60 : 30)
        }
        containerImage.addSubview(descriptionImage)

        descriptionImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(UIDevice.isIpad ? 40 : 30)
            make.width.equalTo(UIDevice.isIpad ? 58 : 44)
        }

        backView.addSubview(tableView)
        backView.addSubview(checkSignView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(checkSignView.snp.bottom).offset(UIDevice.isIpad ? 25:5)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        checkSignView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(UIDevice.isIpad ? 20:10)
            make.height.equalTo(UIDevice.isIpad ? 46 : 36)
            make.horizontalEdges.equalTo(tableView).inset(UIDevice.isIpad ? 120 : 40)
            make.centerX.equalToSuperview()
        }

        checkSignView.addSubviews(minEnabledCategoriesLabel, checkSignImageView)

        minEnabledCategoriesLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(checkSignImageView.snp.right).offset(10)
        }

        checkSignImageView.snp.makeConstraints { make in
            make.size.equalTo(UIDevice.isIpad ? 34 : 20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }

    }

}
