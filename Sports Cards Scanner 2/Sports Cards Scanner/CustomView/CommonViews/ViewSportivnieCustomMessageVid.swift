import UIKit
import SnapKit
func vicheslitFibonc319(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCustomMessageVid: UIView {

    lazy var cardImage: UIImageView = .init(image: SportivinieKartiImages.cardNocards.image)

    lazy var titleLabel: UILabel = { label in
        label.textColor = .singINLabel
        label.font = .font(.ubuntuLight300, size: UIDevice.isIpad ? 22:16)
        label.numberOfLines = 0
        return label
    }(UILabel())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitZagolovok(_ title: String) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        titleLabel.text = title
        titleLabel.setVisotaLabla(UIDevice.isIpad ?30:24)
        titleLabel.textAlignment = .center
    }

    private func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        backgroundColor = .clear
        addSubview(cardImage)
        cardImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(UIDevice.isIpad ? 55:32)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(cardImage.snp.bottom).offset(UIDevice.isIpad ? 20:15)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
    }

}
