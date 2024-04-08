import UIKit
import AVKit
import AVFoundation

enum SCSPremiumMainControllerStyle {
    case mainProduct, unlockContentProduct, unlockFuncProduct, unlockOther
}

class PremiumMainController: UIViewController {
    
    weak var delegate: PremiumMainControllerDelegate?
    
    private weak var player: Player!
    private var view0 = ReusableView()
    private var view1 = ReusableView()
    private var viewTransaction = TransactionView()
    
    @IBOutlet private weak var freeform: UIView!
    @IBOutlet private weak var videoElement: UIView!
    @IBOutlet private weak var restoreBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    var productBuy: SCSPremiumMainControllerStyle = .mainProduct
    
    private var intScreenStatus = 0
    
    override  func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        super.viewWillAppear(animated)
        initVideoElement_unique()
        startMaked_unique()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        super.viewDidAppear(animated)
        if !NetworkStatusMonitor.shared.isNetworkAvailable {
            showMess_unique()
        }
    }
    
    deinit {
        deinitPlayer_unique()
    }
    
    private func initVideoElement_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
            BGPlayer_unique()
        }
    }
    
    
    //MARK: System events
    
    private func deinitPlayer_unique() {
        guard player.isNotNil else { return }
        
        player.volume = 0
        player.url = nil
        player.didMove(toParent: nil)
        player = nil
    }
    
    // MARK: - Setup Video Player
    
    private func BGPlayer_unique() {
        var pathUrl = Bundle.main.url(forResource: SCSConfigurationMediaSub.nameFileVideoForPhone, withExtension: SCSConfigurationMediaSub.videoFileType)
        if UIDevice.current.userInterfaceIdiom == .pad {
            pathUrl = Bundle.main.url(forResource: SCSConfigurationMediaSub.nameFileVideoForPad, withExtension: SCSConfigurationMediaSub.videoFileType)
        } else{
            pathUrl = Bundle.main.url(forResource: SCSConfigurationMediaSub.nameFileVideoForPhone, withExtension: SCSConfigurationMediaSub.videoFileType)
        }
        
        let player = Player()
        player.playerDelegate = self
        player.playbackDelegate = self
        player.view.frame = self.view.bounds
        
        addChild(player)
        view.addSubview(player.view)
        player.didMove(toParent: self)
        player.url = pathUrl
        if UIDevice.current.userInterfaceIdiom == .pad {
            player.playerView.playerFillMode = .resizeAspectFill
        }else{
            player.playerView.playerFillMode = .resize
        }
        player.playbackLoops = true
        view.sendSubviewToBack(player.view)
        self.player = player
    }
    
    // MARK: - Make UI/UX
    
    private func startMaked_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        setRestoreBtn_unique()
        if productBuy == .mainProduct {
            setReusable_unique(config: .first, isHide: false)
            setReusable_unique(config: .second, isHide: true)
            setTransaction_unique(isHide: true)
        } else {
            setTransaction_unique(isHide: false)
            self.showRestore_unique()
        }
    }
    
    //reusable setup
    
    private func generateContentForView_unique(config: SCSConfigView) -> [ReusableContentCell] {
        var contentForCV : [ReusableContentCell] = []
        switch config {
        case .first:
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            return contentForCV
        case .second:
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text1ID"), image: UIImage(named: "2_1des")!, selectedImage: UIImage(named: "2_1sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text2ID"), image: UIImage(named: "2_2des")!, selectedImage: UIImage(named: "2_2sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text3ID"), image: UIImage(named: "2_3des")!, selectedImage: UIImage(named: "2_3sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text4ID"), image: UIImage(named: "2_4des")!, selectedImage: UIImage(named: "2_4sel")!))
            contentForCV.append(ReusableContentCell(title: localizedString(forKey:"Text5ID"), image: UIImage(named: "2_5des")!, selectedImage: UIImage(named: "2_5sel")!))
            return contentForCV
        case .transaction: return contentForCV
        }
    }
    
    private func setReusable_unique(config : SCSConfigView, isHide : Bool){
        var currentView : ReusableView? = nil
        var viewModel : ReusableViewModel? = nil
        switch config {
        case .first:
            viewModel =  ReusableViewModel(title: localizedString(forKey: "TextTitle1ID").uppercased(), items: self.generateContentForView_unique(config: config))
            currentView = self.view0
        case .second:
            viewModel =  ReusableViewModel(title: localizedString(forKey: "TextTitle2ID").uppercased(), items: self.generateContentForView_unique(config: config))
            currentView = self.view1
        case .transaction:
            currentView = nil
        }
        guard let i = currentView else { return }
        i.protocolElement = self
        i.viewModel = viewModel
        i.configView = config
        freeform.addSubview(i)
        freeform.bringSubviewToFront(i)
        
        i.snp.makeConstraints { make in
            make.height.equalTo(338)
            make.width.equalTo(freeform).multipliedBy(1)
            make.centerX.equalTo(freeform).multipliedBy(1)
            make.bottom.equalTo(freeform).offset(0)
        }
        i.isHidden = isHide
    }
    // transaction setup
    
    private func setTransaction_unique(isHide: Bool) {
        self.viewTransaction.inapp.productBuy = self.productBuy
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.viewTransaction.setLocalization_TOC_unique()
        }
        freeform.addSubview(self.viewTransaction)
        freeform.bringSubviewToFront(self.viewTransaction)
        self.viewTransaction.inapp.productBuy = self.productBuy
        self.viewTransaction.snp.makeConstraints { make in
            //            make.height.equalTo(338)
            make.width.equalTo(freeform).multipliedBy(1)
            make.centerX.equalTo(freeform).multipliedBy(1)
            make.bottom.equalTo(freeform).offset(0)
        }
        self.viewTransaction.isHidden = isHide
        self.viewTransaction.delegate = self
    }
    
    // restore button setup
    
    private func setRestoreBtn_unique(){
        self.restoreBtn.isHidden = true
        self.restoreBtn.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        self.restoreBtn.setTitle(localizedString(forKey: "restore"), for: .normal)
        self.restoreBtn.titleLabel?.setShadow_unique()
        self.restoreBtn.tintColor = .white
        self.restoreBtn.setTitleColor(.white, for: .normal)
    }
    
    private func openApp_unique(){
        delegate?.premiumMainControllerUserDidSubscribe(self)
        UIApplication.shared.notificationFeedbackGenerator_unique(type: .success)
        deinitPlayer_unique()
    }
    
    private func showRestore_unique(){
        self.restoreBtn.isHidden = false
        if productBuy != .mainProduct {
            self.closeBtn.isHidden = false
        }
    }
    
    @IBAction func restoreAction_unique(_ sender: UIButton) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.viewTransaction.restoreAction_unique()
    }
    
    @IBAction func closeController_unique(_ sender: UIButton) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        openApp_unique()
    }
}

extension PremiumMainController : SCSReusableViewEvent {
    func nextStep_unique(config: SCSConfigView) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        switch config {
        case .first:
            self.view0.fadeOut_unique()
            self.view1.fadeIn_unique()
            UIApplication.shared.impactFeedbackGenerator_unique(type: .medium)
            ThirdPartyServicesManager.shared.makeATT_unique()
        case .second:
            self.view1.fadeOut_unique()
            self.viewTransaction.fadeIn_unique()
            self.showRestore_unique()
            UIApplication.shared.impactFeedbackGenerator_unique(type: .medium)
        case .transaction: break
        }
    }
}

extension PremiumMainController: SCSNetworkStatusMonitorDelegate {
    func showMess_unique() {
        transactionTreatment_TOC_unique(title: localizedString(forKey: "ConnectivityTitle"), message: localizedString(forKey: "ConnectivityDescription"))
    }
}

extension PremiumMainController : SCSTransactionViewEvents {
    
    func userSubscribed_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.openApp_unique()
    }
    
    func transactionTreatment_TOC_unique(title: String, message: String) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        UIApplication.shared.notificationFeedbackGenerator_unique(type: .warning)
    }
    
    func transactionFailed_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        print(#function)
        UIApplication.shared.notificationFeedbackGenerator_unique(type: .error)
    }
    
    func privacyOpen_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        SCSConfigurations.policyLink.openURL_unique()
    }
    
    func termsOpen_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        SCSConfigurations.termsLink.openURL_unique()
    }
}

extension PremiumMainController: SCSPlayerDelegate, SCSPlayerPlaybackDelegate {
    func playerReady_unique(_ player: Player) { }
    
    func playerPlaybackStateDidChange_unique(_ player: Player) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerBufferingStateDidChange_unique(_ player: Player) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerBufferTimeDidChange_unique(_ bufferTime: Double) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func player_unique(_ player: Player, didFailWithError error: Error?) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerCurrentTimeDidChange_unique(_ player: Player) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerPlaybackWillStartFromBeginning_unique(_ player: Player) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerPlaybackDidEnd_unique(_ player: Player) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerPlaybackWillLoop_unique(_ player: Player) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
    
    func playerPlaybackDidLoop_unique(_ player: Player) { 
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
    }
}

