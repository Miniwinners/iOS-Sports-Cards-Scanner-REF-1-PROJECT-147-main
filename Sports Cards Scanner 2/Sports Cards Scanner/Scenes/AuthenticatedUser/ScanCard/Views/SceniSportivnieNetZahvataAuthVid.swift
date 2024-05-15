import UIKit
import SnapKit
func vicheslitFibonc216(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiNetZahvataAuthVid: UIView {

    lazy var noAuthorizationTitleLabel: UILabel = { label in
        label.text = L10n.ScanCard.NoAuthorization.title(InformaciaOPrilozhenii.appName)
        label.textColor = .white
        label.font = .font(.interMedium, size: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }(UILabel())

    lazy var noAuthorizationDescriptionLabel: UILabel = { label in
        label.text = L10n.ScanCard.NoAuthorization.description
        label.textColor = .white
        label.font = .font(.interRegular, size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }(UILabel())

    lazy var openSettingsButton: UIButton = { button in
        let attributedTitle = NSAttributedString(
            string: L10n.ScanCard.Action.openSettings,
            attributes: [.font: UIFont.font(.interBold, size: 16)]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }(UIButton(type: .system))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }

}

private extension SportivinieKartiNetZahvataAuthVid {
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
        addSubviews(noAuthorizationTitleLabel, noAuthorizationDescriptionLabel, openSettingsButton)
        noAuthorizationTitleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
        }
        noAuthorizationDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(noAuthorizationTitleLabel.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview()
        }
        openSettingsButton.snp.makeConstraints {
            $0.top.equalTo(noAuthorizationDescriptionLabel.snp.bottom).offset(48)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
}
