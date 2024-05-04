import SnapKit
import UIKit

class CheckConnectionVC: UIViewController {

    lazy var connectionView: CheckConnectionView = .init()
    weak var delegate: CheckConnectionDelegate?
    var timer: Timer!
    var progress = 0
    var callBack: (() -> Void)?
    override func loadView() {
        super.loadView()
        view = connectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        startProgress()
    }

    func startProgress() {
        connectionView.progressBar.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }

    @objc func updateProgress() {
        if connectionView.progressBar.progress < 1.0 {
                self.connectionView.progressBar.progress += 0.01
            if self.progress == 100 { return }
                self.progress += 1
                DispatchQueue.main.async {
                    self.connectionView.progressLabel.text = "\(self.progress) %"
                }
        } else {
            timer?.invalidate()
            timer = nil

            handleConnectionCheck()
        }
    }

    func handleConnectionCheck() {
           if checkConnection() {
               delegate?.checkConnectionDidLoad(self)
           } else {
               connectionView.progressBarContainer.isHidden = true
               connectionView.progressLabel.isHidden = true
               connectionView.stackView.isHidden = false
               print("Progress complete!")
           }
       }

    func checkConnection() -> Bool {
        return NetworkMonitoringService.shared.isNetworkAvailable
    }

}
