import UIKit
import SnapKit
func vicheslitFibonc296(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCTVC: UITableViewCell {

    private static let containerHeight: CGFloat = UIDevice.isIpad ? 232 : 157

    lazy var cardView: SportivinieKartiCardMV = .init()

    lazy var separatorView: UIView = .init()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        postavitVidunicalno()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        super.prepareForReuse()
        cardView.resetVid()
    }

    func podgotovitKarty(_ card: SportivinieKartiKartaPredstavlenie) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardView.postavitKarty(card)
    }

    func sdelatProverenim(_ checked: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        cardView.sdelatProverenim(checked)
    }

    func setSelectable(_ selectable: Bool) {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        backgroundView?.subviews.first?.backgroundColor = selectable ? .skyBlue : .highlightColor2
    }

    func setChisloKarti(_ number: Int?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardView.postavitKarteChislo(number)
    }

}

private extension SportivinieKartiCTVC {
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
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        backgroundView = sodatZadniiVid()
        selectedBackgroundView = sozdatVideleniiVid()
        let containerView = UIView()
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        containerView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(SportivinieKartiCTVC.containerHeight)
        }

        cardView.cardImageView.snp.remakeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(UIDevice.isIpad ? 143 : 96)
        }
        cardView.titleLabel.snp.remakeConstraints { make in
            make.top.equalToSuperview().inset(UIDevice.isIpad ? 40:20)
            make.left.equalTo(cardView.cardImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(5)
        }

        cardView.subtitleLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalTo(cardView.titleLabel.snp.bottom).offset(UIDevice.isIpad ? 10:5).priority(.medium)
            make.left.equalTo(cardView.cardImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(5)
            make.height.equalTo(UIDevice.isIpad ? 30:20)
        }

        cardView.pricesLabel.snp.remakeConstraints { make in
            make.bottom.equalToSuperview().inset(UIDevice.isIpad ? 50:30)
            make.height.equalTo(UIDevice.isIpad ? 30:20)
            make.left.equalTo(cardView.cardImageView.snp.right).offset(20)
        }

    }

    func sodatZadniiVid() -> UIView {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let backgroundContainerView = UIView()

        let backgroundView = UIView()
        backgroundView.backgroundColor = .skyBlue
        backgroundView.cornerRadius = UIDevice.isIpad ? 20:12
        backgroundContainerView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(SportivinieKartiCTVC.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return backgroundContainerView
    }

    func sozdatVideleniiVid() -> UIView {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let highlightedContainerView = UIView()

        let highlightedView = UIView()
        highlightedView.backgroundColor = .highlightColor2
        highlightedView.cornerRadius = UIDevice.isIpad ? 20:12
        highlightedContainerView.addSubview(highlightedView)

        highlightedView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(SportivinieKartiCTVC.containerHeight)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        return highlightedContainerView
    }
}
