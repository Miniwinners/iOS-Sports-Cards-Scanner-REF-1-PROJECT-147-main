import UIKit

enum SCSConfigView {
    case first, second, transaction
}

protocol SCSReusableViewEvent: AnyObject {
    func nextStep_unique(config: SCSConfigView)
}

struct ReusableViewModel {
    var title : String
    var items : [ReusableContentCell]
}

struct ReusableContentCell {
    var title : String
    var image : UIImage
    var selectedImage: UIImage
}

class ReusableView: UIView, SCSAnimatedButtonEvent {
    func onClick_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.protocolElement?.nextStep_unique(config: self.configView)
    }
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var titleLb: UILabel!
    @IBOutlet private weak var content: UICollectionView!
    @IBOutlet private weak var nextStepBtn: AnimatedButton!
    @IBOutlet private weak var titleWight: NSLayoutConstraint!
    @IBOutlet private weak var buttonBottom: NSLayoutConstraint!
    
    weak var protocolElement : SCSReusableViewEvent?
    
    var configView : SCSConfigView = .first
    var viewModel : ReusableViewModel? = nil
    private let cellName = "ReusableCell"
    private var selectedStorage : [Int] = []
    private let multic: CGFloat = 0.94
    private let xib = "ReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeReusableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeReusableView()
    }
    
    private func initializeReusableView() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        if UIDevice.current.userInterfaceIdiom == .phone {
            // Устройство является iPhone
            if UIScreen.main.nativeBounds.height >= 2436 {
                // Устройство без физической кнопки "Home" (например, iPhone X и новее)
            } else {
                // Устройство с физической кнопкой "Home"
                buttonBottom.constant = 47
            }
        } else {
            buttonBottom.constant = 63
        }
        
        contentView.fixInView_unique(self)
        nextStepBtn.delegate = self
        nextStepBtn.style = .native
        contentView.backgroundColor = .clear
        setContent_unique()
        setConfigLabels_TOC_unique()
        configScreen_TOC_unique()
    }
    
    private func setContent_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        content.dataSource = self
        content.delegate = self
        content.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
        content.backgroundColor = .clear
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
    }
    
    private func setConfigLabels_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        titleLb.setShadow_unique()
        
        titleLb.textColor = .white
        titleLb.font = UIFont(name: SCSConfigurations.buttonFont, size: 24)
        titleLb.adjustsFontSizeToFitWidth = true
    }
    
    func setConfigView_unique(config: SCSConfigView) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.configView = config
    }
    
    private func setLocalizable_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.titleLb.text = viewModel?.title
    }
    
    //MARK: screen configs
    
    private func configScreen_TOC_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            titleWight.setValue(0.35, forKey: "multiplier")
        } else {
            titleWight.setValue(0.7, forKey: "multiplier")
        }
    }
    
    private func getLastElement_unique() -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        return (viewModel?.items.count ?? 0) - 1
    }
}

extension ReusableView : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        setLocalizable_unique()
        return viewModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        let cell = content.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! ReusableCell
        let content = viewModel?.items[indexPath.item]
        cell.cellLabel.text = content?.title.uppercased()
        if selectedStorage.contains(where: {$0 == indexPath.item}) {
            cell.imageLabel.text = "AKTIV CARD"
            cell.cellLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            cell.imageLabel.textColor = UIColor(red: 0.446, green: 0.446, blue: 0.446, alpha: 1)
            cell.imageLabel.font = UIFont(name: SCSConfigurations.fontName, size: 20)
            cell.contentContainer.backgroundColor = #colorLiteral(red: 0.7372549176, green: 0.7372549176, blue: 0.7372549176, alpha: 1)
            cell.cellLabel.font = UIFont(name: SCSConfigurations.fontName, size: 12)
            cell.imageLabel.setShadow_unique(with: 0.25)
            cell.cellLabel.setShadow_unique(with: 0.25)
        } else {
            cell.imageLabel.text = "INAKTIV CARD"
            cell.cellLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
            cell.imageLabel.textColor = UIColor(red: 0.446, green: 0.446, blue: 0.446, alpha: 0.5)
            cell.contentContainer.backgroundColor = #colorLiteral(red: 0.4941176471, green: 0.4941176471, blue: 0.4941176471, alpha: 1)
            cell.imageLabel.font = UIFont(name: SCSConfigurations.fontName, size: 14)
            cell.cellLabel.font = UIFont(name: SCSConfigurations.fontName, size: 10)
            cell.imageLabel.setShadow_unique(with: 0.5)
            cell.cellLabel.setShadow_unique(with: 0.5)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        if selectedStorage.contains(where: {$0 == indexPath.item}) {
            selectedStorage.removeAll(where: {$0 == indexPath.item})
        } else {
            selectedStorage.append(indexPath.row)
        }
        
        UIApplication.shared.impactFeedbackGenerator_unique(type: .light)
        collectionView.reloadData()
        collectionView.performBatchUpdates(nil, completion: nil)
        if indexPath.last == getLastElement_unique() {
            collectionView.scrollToLastItem_unique(animated: false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        return selectedStorage.contains(indexPath.row) ? CGSize(width: collectionView.frame.height * 0.8, height: collectionView.frame.height) : CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height * 0.85)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}
