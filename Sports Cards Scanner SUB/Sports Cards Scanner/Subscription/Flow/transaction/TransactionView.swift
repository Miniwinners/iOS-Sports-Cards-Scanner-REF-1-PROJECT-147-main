import UIKit

protocol SCSTransactionViewEvents: AnyObject {
    func userSubscribed_unique()
    func transactionTreatment_TOC_unique(title: String, message: String)
    func transactionFailed_unique()
    func privacyOpen_unique()
    func termsOpen_unique()
}

class TransactionView: UIView, SCSAnimatedButtonEvent, SCSIAPManagerProtocol, SCSNetworkStatusMonitorDelegate {
    func showMess_unique() {
        transactionTreatment_TOC_unique(title: localizedString(forKey: "ConnectivityTitle"), message: localizedString(forKey: "ConnectivityDescription"))
    }
    
    private let xib = "TransactionView"
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private(set) weak var title: UILabel!
    @IBOutlet private weak var sliderStack: UIStackView!
    @IBOutlet private weak var trialLb: UILabel!
    @IBOutlet private weak var descriptLb: UILabel!
    @IBOutlet private weak var purchaseBtn: AnimatedButton!
    @IBOutlet private weak var privacyBtn: UIButton!
    @IBOutlet private weak var policyBtn: UIButton!
    @IBOutlet private weak var sliderWight: NSLayoutConstraint!
    @IBOutlet private weak var sliderTop: NSLayoutConstraint!
    @IBOutlet private weak var conteinerWidth: NSLayoutConstraint!
    @IBOutlet private weak var heightView: NSLayoutConstraint!
    
    private let currentFont = SCSConfigurations.fontName
    public let inapp = IAPManager.shared
    private let locale = NSLocale.current.languageCode
    public weak var delegate : SCSTransactionViewEvents?
    private let networkingMonitor = NetworkStatusMonitor.shared
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeTransactionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeTransactionView()
    }
    
    private func initializeTransactionView() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Устройство является iPhone
            if UIScreen.main.nativeBounds.height >= 2436 {
                heightView.constant = 163
            } else {
                //                sliderTop.constant = 60
                heightView.constant = 152
            }
        } else {
            conteinerWidth.constant = 400
            heightView.constant = 167
            //            sliderTop.constant = 45
        }
        contentView.fixInView_unique(self)
        contentView.backgroundColor = .clear
        buildConfigs_TOC_unique()
    }
    
    private func buildConfigs_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        configScreen_TOC_unique()
        setSlider_TOC_unique()
        setConfigLabels_TOC_unique()
        setConfigButtons_TOC_unique()
        setLocalization_TOC_unique()
        configsInApp_TOC_unique()
    }
    
    private func setSlider_TOC_unique(){
        title.text = (localizedString(forKey: "SliderID1").uppercased())
        let texts: [String] = ["\(localizedString(forKey: "SliderID2"))",
                               "\(localizedString(forKey: "SliderID3"))",
                               "\(localizedString(forKey: "SliderID4"))",
        ]
        for t in texts {
            sliderStack.addArrangedSubview(SliderCellView(title: t, subTitle: t.lowercased()))
        }
    }
    
    //MARK: config labels
    
    private func setConfigLabels_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        //slider
        title.textColor = .white
        title.font = UIFont(name: currentFont, size: 24)
        //        title.adjustsFontSizeToFitWidth = true
        title.numberOfLines = 4
        title.setShadow_unique()
        title.lineBreakMode = .byClipping
        if UIDevice.current.userInterfaceIdiom == .pad {
            title.font = UIFont(name: currentFont, size: 24)
        }
        trialLb.setShadow_unique()
        trialLb.font = UIFont(name: currentFont, size: 12)
        trialLb.textColor = .white
        trialLb.textAlignment = .center
        
        descriptLb.setShadow_unique()
        descriptLb.textColor = .white
        descriptLb.textAlignment = .center
        descriptLb.numberOfLines = 0
        descriptLb.font = UIFont.systemFont(ofSize: 15)
        
        privacyBtn.titleLabel?.setShadow_unique()
        privacyBtn.titleLabel?.numberOfLines = 2
        privacyBtn.titleLabel?.textAlignment = .center
        
        privacyBtn.setTitleColor(.white, for: .normal)
        privacyBtn.tintColor = .white
        
        policyBtn.titleLabel?.setShadow_unique()
        policyBtn.titleLabel?.numberOfLines = 2
        policyBtn.titleLabel?.textAlignment = .center
        policyBtn.setTitleColor(.white, for: .normal)
        policyBtn.tintColor = .white
        privacyBtn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
        policyBtn.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 12)
    }
    
    //MARK: config button
    
    private func setConfigButtons_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.purchaseBtn.delegate = self
        self.purchaseBtn.style = .native
    }
    
    //MARK: config localization
    
    public func setLocalization_TOC_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        //        title.labelTextsForSlider = "\(localizedString(forKey: "SliderID1").uppercased())|n\(localizedString(forKey: "SliderID2").uppercased())|n\(localizedString(forKey: "SliderID3").uppercased()) |n\(localizedString(forKey: "SliderID4").uppercased()) |n\(localizedString(forKey: "SliderID5").uppercased())"
        
        let description = localizedString(forKey: "iOSAfterID")
        let localizedPrice = inapp.localizedPrice()
        descriptLb.text = String(format: description, localizedPrice)
        
        if locale == "en" {
            trialLb.text = "Start 3-days for FREE\nThen \(localizedPrice)/week".uppercased()
        } else {
            trialLb.text = ""
        }
        privacyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        privacyBtn.setAttributedTitle(localizedString(forKey: "TermsID").underLined, for: .normal)
        policyBtn.titleLabel?.lineBreakMode = .byWordWrapping
        policyBtn.setAttributedTitle(localizedString(forKey: "PrivacyID").underLined, for: .normal)
    }
    
    //MARK: screen configs
    
    private func configScreen_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            sliderWight.setValue(0.5, forKey: "multiplier")
        } else {
            sliderWight.setValue(0.8, forKey: "multiplier")
        }
    }
    
    //MARK: configs
    
    private func configsInApp_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.inapp.transactionsDelegate = self
        self.networkingMonitor.delegate = self
    }
    
    public func restoreAction_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        inapp.doRestore()
    }
    
    //MARK: actions
    
    @IBAction func privacyAction_unique(_ sender: UIButton) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.delegate?.termsOpen_unique()
    }
    
    @IBAction func termsAction_unique(_ sender: UIButton) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.delegate?.privacyOpen_unique()
    }
    
    func onClick_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        UIApplication.shared.impactFeedbackGenerator_unique(type: .heavy)
        guard networkingMonitor.isNetworkAvailable else {
            showMess_unique()
            return
        }
        inapp.doPurchase()
        purchaseBtn.isUserInteractionEnabled = false
    }
    
    //inapp
    
    func transactionTreatment_TOC_unique(title: String, message: String) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.transactionTreatment_TOC_unique(title: title, message: message)
    }
    
    func infoAlert_unique(title: String, message: String) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.transactionTreatment_TOC_unique(title: title, message: message)
    }
    
    func goToTheApp_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.userSubscribed_unique()
    }
    
    func failed() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        purchaseBtn.isUserInteractionEnabled = true
        self.delegate?.transactionFailed_unique()
    }
}
