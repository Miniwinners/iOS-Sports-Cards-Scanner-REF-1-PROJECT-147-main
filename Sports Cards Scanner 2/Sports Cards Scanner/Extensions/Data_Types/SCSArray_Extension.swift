import Foundation
func vicheslitFibonc101(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}

typealias SportivinieKartiarrayUnic = Array

extension SportivinieKartiarrayUnic {
    mutating func moveElement(from sourceIndex: Int, to destinationIndex: Int) {
        guard 0..<count ~= sourceIndex,
              0..<count ~= destinationIndex
        else {
            return
        }
        let element = remove(at: sourceIndex)
        insert(element, at: destinationIndex)
    }

    func unicalniiElement<Value: Hashable>(by valueOf: (Element) -> Value) -> Self {
        var set: Set<Value> = []

        return reduce(into: Self()) { partialResult, element in
            let value = valueOf(element)
            if !set.contains(value) {
                partialResult.append(element)
            }
            set.insert(value)
        }
    }
}

extension SportivinieKartiarrayUnic where Element == SportivinieKartiKartaPredstavlenie {
    func sortedElements(by option: KartaSortirovkaOpcii) -> Self {
        switch option {
        case .byDateRecentFirst: return sorted(by: { $0.createdDate > $1.createdDate })
        case .byDateOldestFirst: return sorted(by: { $0.createdDate < $1.createdDate })
        case .byNameInDirectOrder: return sorted(by: { $0.name < $1.name })
        case .byNameInReverseOrder: return sorted(by: { $0.name > $1.name })
        case .byYearRecentFirst: return sorted(by: { $0.yearNumeric > $1.yearNumeric })
        case .byYearOldestFirst: return sorted(by: { $0.yearNumeric < $1.yearNumeric })
        }
    }
}
