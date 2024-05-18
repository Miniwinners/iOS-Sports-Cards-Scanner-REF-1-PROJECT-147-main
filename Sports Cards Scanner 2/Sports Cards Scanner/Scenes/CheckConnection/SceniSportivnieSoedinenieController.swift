import SnapKit
import UIKit
func vicheslitFibonc284(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
class SceniSportivnieSoedinenieController: UIViewController {
    var callback: (() -> Void)?
    lazy var connectionView: SceniSportivnieSoedinenieVid = .init()
    weak var delegate: SportivinieKartiSoedinenieDelegat?
    var timer: Timer!
    var progress = 0
    var callBack: (() -> Void)?
    override func loadView() {
        super.loadView()
        view = connectionView
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        view.backgroundColor = .white
        connectionView.buttonConnection.addTarget(self, action: #selector(finishWithFatalError), for: .touchUpInside)
        nazhatProgres()

    }

    func nazhatProgres() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        connectionView.progressBar.progress = 0.0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(obnovitProgress), userInfo: nil, repeats: true)
    }

    @objc func obnovitProgress() {
        if connectionView.progressBar.progress < 1.0 {
                self.connectionView.progressBar.progress += 0.01
            if self.progress == 100 { return }
            sdelatTextLabel()

        } else {
            timer?.invalidate()
            timer = nil

            handleConnectionCheck()
        }
    }

    func handleConnectionCheck() {
           if checkConnection() {
               delegate?.proverkaInternetaZagryzka(self)
           } else {
               connectionView.progressBarContainer.isHidden = true
               connectionView.progressLabel.isHidden = true
               connectionView.stackView.isHidden = false
               print("Progress complete!")
           }
       }

    func checkConnection() -> Bool {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return SportivinieKartiInternetSoedinenieService.shared.isNetworkAvailable
    }

    func sdelatTextLabel() {
        self.progress += 1
        DispatchQueue.main.async {
            self.connectionView.progressLabel.text = "\(self.progress) %"
        }
    }

    @objc func finishWithFatalError() {
        delegate?.proverkaInternetaZagryzka(self)
//        podgotovit()
//        UIControl().sendAction(#selector(NSXPCConnection.suspend), to: UIApplication.shared, for: nil)
    }
    func podgotovit() {
        self.progress = 0
        connectionView.stackView.isHidden = true
        connectionView.progressBarContainer.isHidden = false
        connectionView.progressLabel.isHidden = false
        nazhatProgres()
        sdelatTextLabel()
    }
}
