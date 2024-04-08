import UIKit

protocol SCSAnimatedButtonEvent : AnyObject {
    func onClick_unique()
}

enum SCSAnimationButtonStyle {
    case gif, native
}

class AnimatedButton: UIView {
    
    @IBOutlet private var contentSelf: UIView!
    @IBOutlet private weak var backgroundSelf: UIImageView!
    @IBOutlet private weak var titleSelf: UILabel!
    
    weak var delegate: SCSAnimatedButtonEvent?
    private let currentFont = SCSConfigurations.fontName
    private var persistentAnimations: [String: CAAnimation] = [:]
    private var persistentSpeed: Float = 0.0
    private let xib = "AnimatedButton"
    
    var style : SCSAnimationButtonStyle = .native
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeAnimatedButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeAnimatedButton()
    }
    
    // Этот метод будет вызван, когда view добавляется к superview
    override func didMoveToSuperview() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        super.didMoveToSuperview()
        if style == .native {
            setPulseAnimation_unique()
            addNotificationObservers_unique()
        }
        
    }
    
    // Этот метод будет вызван перед тем, как view будет удален из superview
    override func willMove(toSuperview newSuperview: UIView?) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        super.willMove(toSuperview: newSuperview)
        if style == .native {
            if newSuperview == nil {
                self.layer.removeAllAnimations()
                removeNotificationObservers_unique()
            }
        }
    }
    
    private func addNotificationObservers_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseAnimation_unique), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resumeAnimation_unique), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    private func removeNotificationObservers_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc private func pauseAnimation_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.persistentSpeed = self.layer.speed
        
        self.layer.speed = 1.0 //in case layer was paused from outside, set speed to 1.0 to get all animations
        self.persistAnimations_unique(withKeys: self.layer.animationKeys())
        self.layer.speed = self.persistentSpeed //restore original speed
        
        self.layer.pauseButtonAnimation()
    }
    
    @objc private func resumeAnimation_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        self.restoreAnimations_unique(withKeys: Array(self.persistentAnimations.keys))
        self.persistentAnimations.removeAll()
        if self.persistentSpeed == 1.0 { //if layer was plaiyng before backgorund, resume it
            self.layer.resumeButtonAnimation()
        }
    }
    
    func persistAnimations_unique(withKeys: [String]?) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        withKeys?.forEach({ (key) in
            if let animation = self.layer.animation(forKey: key) {
                self.persistentAnimations[key] = animation
            }
        })
    }
    
    func restoreAnimations_unique(withKeys: [String]?) {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        withKeys?.forEach { key in
            if let persistentAnimation = self.persistentAnimations[key] {
                self.layer.add(persistentAnimation, forKey: key)
            }
        }
    }
    
    private func initializeAnimatedButton() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        Bundle.main.loadNibNamed(xib, owner: self, options: nil)
        contentSelf.fixInView_unique(self)
        contentSelf.backgroundColor = #colorLiteral(red: 0.4901960784, green: 0.4901960784, blue: 0.4901960784, alpha: 1)
        contentSelf.layer.cornerRadius = 8
        animationBackgroundInit_unique()
        
    }
    
    private func animationBackgroundInit_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        titleSelf.text = localizedString(forKey: "iOSButtonID")
        titleSelf.font = UIFont(name: currentFont, size: 29)
        titleSelf.textColor = .white
        titleSelf.minimumScaleFactor = 11/22
        if style == .native {
            setPulseAnimation_unique()
        }else {
            do {
                let gif = try UIImage(gifName: "btn_gif.gif")
                backgroundSelf.setGifImage(gif)
            } catch {
                print(error)
            }
        }
        
        self.onClick_unique(target: self, #selector(click_unique))
    }
    
    @objc func click_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        delegate?.onClick_unique()
    }
}

extension UIView {
    func setPulseAnimation_unique(){
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.duration = 1
        pulseAnimation.toValue = 0.95
        pulseAnimation.fromValue = 0.79
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        self.layer.add(pulseAnimation, forKey: "pulse")
    }
}

extension CALayer {
    func pauseButtonAnimation() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        if self.isButtonAnimationPaused() == false {
            let pausedTime: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil)
            self.speed = 0.0
            self.timeOffset = pausedTime
        }
    }
    
    func isButtonAnimationPaused() -> Bool {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        return self.speed == 0.0
    }
    
    func resumeButtonAnimation() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        let pausedTime: CFTimeInterval = self.timeOffset
        self.speed = 1.0
        self.timeOffset = 0.0
        self.beginTime = 0.0
        let timeSincePause: CFTimeInterval = self.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        self.beginTime = timeSincePause
    }
}
