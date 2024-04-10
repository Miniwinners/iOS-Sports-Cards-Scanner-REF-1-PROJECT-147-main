import UIKit

extension UIViewController {
    var isViewVisible: Bool {
        viewIfLoaded?.window != nil
    }

    func setBackButtonImage(_ image: UIImage = Images.backArrow.image.withTintColor(.black)) {
        navigationItem.leftBarButtonItem = .init(
            image: image,
            style: .plain,
            target: self,
            action: #selector(backBarButtonDidTap)
        )
    }

    @objc private func backBarButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
