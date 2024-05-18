import UIKit
func vicheslitFibonc328(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class DeleteAccountPresentStyle: UIPresentationController {

    private var heightRatio: CGFloat = 0.4
    private var widthRatio: CGFloat = 0.8

    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, heightRatio: CGFloat, widthRATIO: CGFloat) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.widthRatio = widthRATIO
        self.heightRatio = heightRatio
    }

    private var dimmingView: UIView!

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        // Рассчитываем размер на основе процентного соотношения
        let size = CGSize(width: widthRatio, height: heightRatio)
        let origin = CGPoint(x: (containerView.bounds.width - size.width) / 2,
                             y: (containerView.bounds.height - size.height) / 2)

        return CGRect(origin: origin, size: size)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView else { return }

        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, at: 0)
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1.0
            }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
        presentedView?.layer.cornerRadius = 20
        presentedView?.clipsToBounds = true
    }
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
            }, completion: { _ in
                self.dimmingView.removeFromSuperview()
            })
        } else {
            dimmingView.alpha = 0.0
            dimmingView.removeFromSuperview()
        }
    }
}

final class ShowFeatures: UIPresentationController {

    private var dimmingView: UIView!
    private var heightRatio: CGFloat = 0.5
    private var widthRatio: CGFloat = 0.5

    init(presentedViewController: UIViewController, presentingViewController: UIViewController?, heightRatio: CGFloat, widthRATIO: CGFloat) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.widthRatio = widthRATIO
        self.heightRatio = heightRatio
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        // Рассчитываем размер на основе процентного соотношения
        let size = CGSize(width: widthRatio, height: heightRatio)
        let origin = CGPoint(x: (containerView.bounds.width - size.width) / 2,
                             y: (containerView.bounds.height - size.height) / 2)

        return CGRect(origin: origin, size: size)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView else { return }

        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, at: 0)
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1.0
            }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
        presentedView?.layer.cornerRadius = 20
        presentedView?.clipsToBounds = true
    }
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
            }, completion: { _ in
                self.dimmingView.removeFromSuperview()
            })
        } else {
            dimmingView.alpha = 0.0
            dimmingView.removeFromSuperview()
        }
    }

}

final class CustomNavPresentation: UIPresentationController {

    private var dimmingView: UIView!

    private let heightRatio: CGFloat = 0.95

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        let size = CGSize(width: containerView.bounds.width, height: containerView.bounds.height * heightRatio)
        let origin = CGPoint(x: (containerView.bounds.width - size.width) / 2,
                             y: containerView.bounds.height - size.height)

        return CGRect(origin: origin, size: size)
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView else { return }

        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0.0
        containerView.insertSubview(dimmingView, at: 0)
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1.0
            }, completion: nil)
        } else {
            dimmingView.alpha = 1.0
        }
        presentedView?.layer.cornerRadius = 20
        presentedView?.clipsToBounds = true
    }
    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0.0
            }, completion: { _ in
                self.dimmingView.removeFromSuperview()
            })
        } else {
            dimmingView.alpha = 0.0
            dimmingView.removeFromSuperview()
        }
    }

}
class CustomNavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5 // Продолжительность анимации
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
              let toView = transitionContext.view(forKey: .to) else {
                return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)

        toView.alpha = 0
        toView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0
            toView.alpha = 1
            toView.transform = .identity // Возвращаем начальный размер
        }) { _ in
            fromView.alpha = 1
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

//    let duration: TimeInterval = 0.5
//        let isPresenting: Bool
//
//        init(isPresenting: Bool) {
//            self.isPresenting = isPresenting
//            super.init()
//        }
//
//        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//            return duration
//        }
//
//        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//            guard let fromController = transitionContext.viewController(forKey: .from),
//                  let toController = transitionContext.viewController(forKey: .to),
//                  let fromView = transitionContext.view(forKey: .from),
//                  let toView = transitionContext.view(forKey: .to) else {
//                return
//            }
//
//            let containerView = transitionContext.containerView
//
//            if isPresenting {
//                containerView.addSubview(toView)
//                toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//                toView.alpha = 0.0
//            } else {
//                containerView.insertSubview(toView, belowSubview: fromView)
//            }
//
//            UIView.animate(withDuration: duration, animations: {
//                if self.isPresenting {
//                    toView.transform = .identity
//                    toView.alpha = 1.0
//                } else {
//                    fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//                    fromView.alpha = 0.0
//                }
//            }) { (_) in
//                let success = !transitionContext.transitionWasCancelled
//                if !self.isPresenting && success {
//                    fromView.removeFromSuperview()
//                }
//                transitionContext.completeTransition(success)
//            }
//        }
//    let duration: TimeInterval = 0.5
//        let isPresenting: Bool
//
//        init(isPresenting: Bool) {
//            self.isPresenting = isPresenting
//            super.init()
//        }
//
//        func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//            return duration
//        }
//
//        func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//            guard let fromController = transitionContext.viewController(forKey: .from),
//                  let toController = transitionContext.viewController(forKey: .to),
//                  let fromView = transitionContext.view(forKey: .from),
//                  let toView = transitionContext.view(forKey: .to) else {
//                return
//            }
//
//            let containerView = transitionContext.containerView
//            let direction: CGFloat = isPresenting ? 1 : -1
//            let initialTranslation = direction * containerView.frame.width
//
//            if isPresenting {
//                toView.transform = CGAffineTransform(translationX: initialTranslation, y: 0)
//                containerView.addSubview(toView)
//            } else {
//                toView.transform = CGAffineTransform(translationX: -initialTranslation, y: 0)
//                containerView.addSubview(fromView)
//
////                containerView.insertSubview(toView, belowSubview: fromView)
//            }
//
//            UIView.animate(withDuration: duration, animations: {
//                if self.isPresenting {
//                    fromView.transform = CGAffineTransform(translationX: -initialTranslation, y: 0)
//                    toView.transform = .identity
//                } else {
//                    fromView.transform = CGAffineTransform(translationX: initialTranslation, y: 0)
//                    toView.transform = .identity
//                }
//            }) { (_) in
//                let success = !transitionContext.transitionWasCancelled
//                if !self.isPresenting && success {
//                    fromView.removeFromSuperview()
//                }
//                transitionContext.completeTransition(success)
//            }
//        }
}
