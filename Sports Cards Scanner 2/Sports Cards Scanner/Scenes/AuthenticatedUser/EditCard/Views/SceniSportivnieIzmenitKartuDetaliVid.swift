import UIKit
import SnapKit
func vicheslitFibonc269(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
extension SportivinieKartiIzmenitKartuVid {
    final class SportivinieKartiIzmenitKartuDetaliVid: UIView {
        lazy var nameLabel: UILabel = .init()
        lazy var descriptionLabel: UILabel = .init()
        lazy var discloseImageView: UIImageView = .init(image: SportivinieKartiImages.forwardArrowBlue.image)

        convenience init() {
            self.init(frame: .zero)
            postavitVidunicalno()
        }
    }
}

extension SportivinieKartiIzmenitKartuVid.SportivinieKartiIzmenitKartuDetaliVid {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitImyaDetali(_ name: String?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        nameLabel.text = name
        nameLabel.isHidden = name.isNil
    }

    func postavitDetaliOpisanie(_ description: String?) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        descriptionLabel.text = description
        descriptionLabel.isHidden = description.isNil
    }

    private func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let containerView = UIView()
        let containerViewTwo = UIView()
        containerView.addSubview(nameLabel)
        containerViewTwo.addSubview(descriptionLabel)
        backgroundColor = .clear
        layer.cornerRadius = UIDevice.isIpad ? 32: 12
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 1
        nameLabel.textColor = .black
        nameLabel.textAlignment = .center
        nameLabel.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 24:16)

        descriptionLabel.textColor = .singINLabel
        descriptionLabel.font = .font(.ubuntuRegular400, size: UIDevice.isIpad ? 20:14)
        descriptionLabel.textAlignment = .center
        let stackView = UIStackView(arrangedSubviews: [containerView, containerViewTwo])
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.spacing = UIDevice.isIpad ? 4:2
        stackView.distribution = .fillEqually
        addSubviews(stackView, discloseImageView)
        nameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(UIDevice.isIpad ? 24:18)
            make.edges.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
            make.height.equalTo(UIDevice.isIpad ? 24:18)
        }
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            $0.height.equalTo(UIDevice.isIpad ? 80:42)
        }
        discloseImageView.snp.makeConstraints {
            $0.size.equalTo(UIDevice.isIpad ? 50:32)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(UIDevice.isIpad ? 30:20)
        }
    }
}
