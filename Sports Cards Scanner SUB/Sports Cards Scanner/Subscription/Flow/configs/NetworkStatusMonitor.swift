import UIKit
import Network

protocol SCSNetworkStatusMonitorDelegate : AnyObject {
    func showMess_unique()
}

class NetworkStatusMonitor {
    static let shared = NetworkStatusMonitor()
    
    private let queue = DispatchQueue(label: "NetworkStatusMonitor")
    private let nwMonitor: NWPathMonitor
    
    weak var delegate : SCSNetworkStatusMonitorDelegate?
    
    private(set) var isNetworkAvailable: Bool = true {
        didSet {
            if !isNetworkAvailable {
                print("No internet connection.")
                self.delegate?.showMess_unique()
            } else {
                print("Internet connection is active.")
            }
        }
    }
    
    private init() {
        nwMonitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                let isNetworkAvailable = path.status == .satisfied
                guard isNetworkAvailable != self.isNetworkAvailable else { return }
                self.isNetworkAvailable = isNetworkAvailable
            }
        }
        nwMonitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        nwMonitor.cancel()
    }
}
