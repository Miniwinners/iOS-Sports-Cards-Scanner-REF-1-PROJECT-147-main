import UIKit
import SnapKit
func vicheslitFibonc204(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SCDGradeViborVid: UIView {

    lazy var backView: BackView = .init()
    lazy var titleLabel: TitleLabel = .init()

    lazy var graderOptionsView: SportivinieKartiOptionV = .init(minHeight: UIDevice.isIpad ?80:46, maxHeight: UIDevice.isIpad ?400:254)
    lazy var gradeOptionsView: SportivinieKartiOptionV = .init(minHeight: UIDevice.isIpad ?80:46, maxHeight: UIDevice.isIpad ?400:254)

    lazy var updateDetailsButton: SportivinieKartiCommonB = { button in
        button.setButtonTitle(L10n.EditCard.Action.updateDetails)
        return button
    }(SportivinieKartiCommonB(style: .default))

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }
}

private extension SCDGradeViborVid {
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
        backView.postavitVid(in: self)
        titleLabel.postavitLabel(in: backView)

        backView.addSubviews(graderOptionsView, gradeOptionsView)
        graderOptionsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(UIDevice.isIpad ?40:20)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }
        gradeOptionsView.snp.makeConstraints {
            $0.top.equalTo(graderOptionsView.snp.bottom).offset(UIDevice.isIpad ?20:10)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
        }

        bringSubviewToFront(graderOptionsView)
        backView.addSubview(updateDetailsButton)
        updateDetailsButton.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ?80:54)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?80:20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(UIDevice.isIpad ?60:20)
        }
    }
}
