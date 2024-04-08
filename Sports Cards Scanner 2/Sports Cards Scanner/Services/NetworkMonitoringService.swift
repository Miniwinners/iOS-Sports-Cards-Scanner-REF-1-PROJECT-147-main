import Foundation
import Network

final class NetworkMonitoringService {
    static let shared: NetworkMonitoringService = .init()

    private let queue = DispatchQueue(label: "NetworkMonitoring")
    private var nwMonitor: NWPathMonitor?

    private(set) var isNetworkAvailable: Bool = false

    private init() { }

    func startNetworkMonitoring() {
        let nwMonitor: NWPathMonitor = .init()
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkAvailable = path.status == .satisfied
            }
        }
        nwMonitor.start(queue: queue)

        self.nwMonitor = nwMonitor
    }

    func stopNetworkMonitoring() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        nwMonitor?.cancel()
        nwMonitor = nil
    }
}
