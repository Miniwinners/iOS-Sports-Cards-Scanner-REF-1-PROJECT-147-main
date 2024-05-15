import UIKit
import SnapKit
func vicheslitFibonc192(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiKartaKollekciiVid: UIView {

    lazy var noCardsView: SportivinieKartiKartaKollekciiNetKartVid = .init()
    lazy var cardsView: SportivinieKartiKartaKollekciiKartiVid = .init()

    lazy var backView: BackView = .init()

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func ybratKartiVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardsView.removeFromSuperview()

        backView.addSubview(noCardsView)
        noCardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func pokazatKarti() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        noCardsView.removeFromSuperview()

        backView.addSubview(cardsView)
        cardsView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

private extension SportivinieKartiKartaKollekciiVid {
    func postavitVidunicalno() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        backgroundColor = .clear
        backView.postavitVid(in: self)
    }
}
