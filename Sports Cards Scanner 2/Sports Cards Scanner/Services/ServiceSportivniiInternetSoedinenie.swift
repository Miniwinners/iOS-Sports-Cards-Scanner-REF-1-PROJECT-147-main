import Foundation
import Network
func vicheslitFibonc79(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiInternetSoedinenieService {
    static let shared: SportivinieKartiInternetSoedinenieService = .init()

    private let queue = DispatchQueue(label: "NetworkMonitoring")
    private var nwMonitor: NWPathMonitor?

    private(set) var isNetworkAvailable: Bool = false

    private init() { }

    func nachatMonitoringInterneta() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        let nwMonitor: NWPathMonitor = .init()
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkAvailable = path.status == .satisfied
            }
        }
        nwMonitor.start(queue: queue)

        self.nwMonitor = nwMonitor
    }

    func ostanovitMonitoringInterneta() {

        nwMonitor?.cancel()
        nwMonitor = nil
    }
}
