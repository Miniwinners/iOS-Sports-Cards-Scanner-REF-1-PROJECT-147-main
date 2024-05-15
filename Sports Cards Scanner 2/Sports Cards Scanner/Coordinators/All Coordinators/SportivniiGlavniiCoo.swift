import UIKit

protocol SportivinieKartiCoo: AnyObject {
    var children: [SportivinieKartiCoo] { get set }
    var router: SportivinieKartiGlavniiRouterPrilozhania { get }

    func pokazatNachalnoePredstavlenie(animated: Bool, onDismissed: Closure?)
    func ischeznytPolnostuu(animated: Bool)
    func predstavitDocherniiCoo(_ coordinator: SportivinieKartiCoo, animated: Bool, onDismissed: Closure?)
}

extension SportivinieKartiCoo {
    func ischeznytPolnostuu(animated: Bool) {

        router.ischeznytPolnostuu(animated: animated)
    }

    func predstavitDocherniiCoo(_ child: SportivinieKartiCoo, animated: Bool, onDismissed: Closure?) {
        children.append(child)
        child.pokazatNachalnoePredstavlenie(animated: animated) { [weak self, weak child] in
            guard let self = self, let child = child else { return }
            self.ybratDocherniiCoo(child)
            onDismissed?()
        }
    }

    private func ybratDocherniiCoo(_ child: SportivinieKartiCoo) {

        guard let index = children.firstIndex(where: { $0 === child }) else {
            return
        }
        children.remove(at: index)
    }
}

enum UnicalniEnumSix {
    case one
    case two
    case three
}
