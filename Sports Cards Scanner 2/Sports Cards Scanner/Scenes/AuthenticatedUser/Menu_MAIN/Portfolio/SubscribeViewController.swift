import UIKit
final class SubscribeViewController: UIViewController {
    
    
    lazy var transactionView: TransactionView = .init()
    
    
    override func loadView() {
        view = transactionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
