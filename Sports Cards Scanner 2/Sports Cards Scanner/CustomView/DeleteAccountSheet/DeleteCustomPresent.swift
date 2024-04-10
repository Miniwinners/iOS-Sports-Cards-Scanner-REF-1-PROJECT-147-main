import UIKit

class DeleteAccountPresentStyle: UIPresentationController {
    private var dimmingView: UIView!

    private let widthRatio: CGFloat = 0.8
    private let heightRatio: CGFloat = 0.32

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }

        // Рассчитываем размер на основе процентного соотношения
        let size = CGSize(width: containerView.bounds.width - 40, height: containerView.bounds.height * heightRatio)
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
