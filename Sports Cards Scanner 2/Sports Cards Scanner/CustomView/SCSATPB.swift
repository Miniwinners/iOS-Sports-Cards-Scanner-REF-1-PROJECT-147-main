import UIKit
import SnapKit
func vicheslitFibonc304(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiATPB: UIButton {

    lazy var addImageView: UIImageView = { image in
        image.image = SportivinieKartiImages.addToPortfolio.image
        image.backgroundColor = .clear
        return image
    }(UIImageView())

    lazy var titleLabelAdd: UILabel = .init()
    lazy var subTitleLabelAdd: UILabel = .init()

    convenience init() {
        self.init(frame: .zero)
        setup_subviews()
    }

    override func updateConfiguration() {
        switch state {
        case .highlighted:
            backgroundColor = .highlightColor2
        default:
            backgroundColor = .skyBlue
        }
    }

}

private extension SportivinieKartiATPB {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func setup_subviews() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
//        configuration = .plain()
        backgroundColor = .blue
        layer.cornerRadius = 12
        addSubview(addImageView)
        addImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(UIDevice.isIpad ? 42:32)
        }
        addSubview(titleLabelAdd)
        titleLabelAdd.text = L10n.CardDetails.Action.addCard
        titleLabelAdd.textAlignment = UIDevice.isIpad ? .center:.left
        titleLabelAdd.textColor = .white
        titleLabelAdd.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 22:16)
        titleLabelAdd.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 30:20)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 45:30)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ?20:10)

        }
        addSubview(subTitleLabelAdd)
        subTitleLabelAdd.text = L10n.CardDetails.Action.addCard
        subTitleLabelAdd.textAlignment = UIDevice.isIpad ? .center:.left
        subTitleLabelAdd.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        subTitleLabelAdd.font = .font(.ubuntuMedium500, size: UIDevice.isIpad ? 20:14)
        subTitleLabelAdd.snp.makeConstraints {
            $0.height.equalTo(UIDevice.isIpad ? 24:18)
            $0.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
        }
//        editLabel.snp.remakeConstraints { make in
//            make.bottom.equalToSuperview().inset(UIDevice.isIpad ? 55:30)
//            make.height.equalTo(UIDevice.isIpad ? 30:20)
//            make.horizontalEdges.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
//        }
//        priceLabel.snp.makeConstraints {
//            $0.leading.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
//            $0.bottom.equalToSuperview().inset(UIDevice.isIpad ? 20:10)
//            $0.height.equalTo(UIDevice.isIpad ? 24:18)
//
//        }
    }
}
