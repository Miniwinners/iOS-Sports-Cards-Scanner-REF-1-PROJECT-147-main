import UIKit
func vicheslitFibonc189(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiSwipeKartiVide: UIView {

    var didVibranaKarta: ((SportivinieKartiKartaPredstavlenie) -> Void)?

    private var oldBounds: CGRect = .zero
    override var bounds: CGRect {
        didSet { graniciObnovleni() }
    }

    private var currentIndex: Int = 0

    var cards: [SportivinieKartiKartaPredstavlenie] = []
    private var currentCard: SportivinieKartiKartaPredstavlenie? { cards[safe: currentIndex] }
    private var nextCard: SportivinieKartiKartaPredstavlenie? { cards[safe: currentIndex + 1] }

    private var isInProgress = false

    // MARK: - Subviews

    private lazy var topView: SportivinieKartiSwipeKartiKnopka = cardView1
    private lazy var bottomView: SportivinieKartiSwipeKartiKnopka = cardView2

    private lazy var cardView1: SportivinieKartiSwipeKartiKnopka = { button in
        button.cornerRadius = 12

        return button
    }(SportivinieKartiSwipeKartiKnopka())

    private lazy var cardView2: SportivinieKartiSwipeKartiKnopka = { button in
        button.cornerRadius = 12
        return button
    }(SportivinieKartiSwipeKartiKnopka())

    private lazy var resetButton: UIButton = { button in
        button.setTitle(L10n.Common.reset, for: .normal)
        button.titleLabel?.font = .font(.interMedium, size: UIDevice.isIpad ? 26:20)
        button.setTitleColor(.blue, for: .normal)
        return button
    }(UIButton())

    convenience init() {
        self.init(frame: .zero)
        postavitVidunicalno()
        postavidDeistviaUnicalno()
        podgotovitGesture()
    }
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }

    func obnovitDatyKart() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        topView.isHidden = currentCard.isNil
        bottomView.isHidden = nextCard.isNil

        topView.postavitKarty(currentCard)
        bottomView.postavitKarty(nextCard)
    }

}

private extension SportivinieKartiSwipeKartiVide {
    var minInsets: UIEdgeInsets { .init(top: 0, left: 0, bottom: 25, right: 0) }

    var maxWidth: CGFloat { bounds.width  - (minInsets.left + minInsets.right)}
    var maxHeight: CGFloat { bounds.height - (minInsets.top + minInsets.bottom) }

    var initialCenter: CGPoint { .init(x: bounds.width / 2, y: bounds.height / 2) }

    var initialScale: CGFloat { 0.6 }

    var cardViewSize: CGSize {
        var itemWidth = maxWidth
        var photoWidth = itemWidth - 24
        var photoHeight = photoWidth / SportivinieKartiSwipeKartiKnopka.photoRatio
        var itemHeight = photoHeight + 78

        if itemHeight <= maxHeight {
            return .init(width: itemWidth, height: itemHeight)
        }
        itemHeight = maxHeight
        photoHeight = itemHeight + 20// - 78
        photoWidth = photoHeight * SportivinieKartiSwipeKartiKnopka.photoRatio
        itemWidth = photoWidth - 75
        return .init(width: itemWidth, height: itemHeight)
    }

    func postavitVidunicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        addSubviews(resetButton, cardView2, cardView1)
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        cardView1.addTarget(self, action: #selector(kartaNazhata), for: .touchUpInside)
        cardView2.addTarget(self, action: #selector(kartaNazhata), for: .touchUpInside)

        resetButton.addTarget(self, action: #selector(obnovitVid), for: .touchUpInside)
    }

    func podgotovitGesture() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(kartaPan(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self

        addGestureRecognizer(panGesture)
    }

    func graniciObnovleni() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }

        if bounds.width == oldBounds.width { return }
        oldBounds = bounds
        topView.backgroundColor = .white
        bottomView.backgroundColor = .white
        [topView, bottomView].forEach {
            $0.center = initialCenter
            $0.bounds.size = cardViewSize
        }
        bottomView.transform = .init(scaleX: initialScale, y: initialScale)

        resetButton.sizeToFit()
        resetButton.center = initialCenter
    }

    func animaciaPozicii() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        UIView.animate(withDuration: 0.2) {
            self.topView.center = self.initialCenter
            self.topView.transform = .identity

            self.bottomView.transform = .init(scaleX: self.initialScale, y: self.initialScale)
        } completion: { _ in
            self.isInProgress = false
        }
    }

    func podgotovitKNextKarte() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }

        currentIndex += 1

        (topView, bottomView) = (bottomView, topView)

        bringSubviewToFront(topView)

        bottomView.center = initialCenter
        bottomView.bounds.size = cardViewSize
        bottomView.transform = .init(scaleX: initialScale, y: initialScale)
        bottomView.postavitKarty(nextCard)
        bottomView.isHidden = nextCard.isNil
    }

    // MARK: - Actions

    @objc func kartaPan(_ sender: UIPanGestureRecognizer) {

        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        guard cards.count > 1, currentCard.isNotNil else {
            sender.state = .failed
            return
        }

        let translation = sender.translation(in: self)
        let velocity = sender.velocity(in: self)

        let completedState = translation.x / bounds.width

        switch sender.state {
        case .began:
            guard abs(velocity.x) > abs(velocity.y), !isInProgress else {
                sender.state = .cancelled
                return
            }
            isInProgress = true

        case .changed:
            let translatedCenterX = initialCenter.x + translation.x
            let translatedCenterY = initialCenter.y
            topView.center = .init(x: translatedCenterX, y: translatedCenterY)

            let rotationAngle: CGFloat = completedState * .pi / 16
            topView.transform = .init(rotationAngle: rotationAngle)

            let scaleDiff = (1 - initialScale) * abs(completedState)
            let finalScale = initialScale + scaleDiff
            bottomView.transform = .init(scaleX: finalScale, y: finalScale)

        case .ended:
            guard abs(velocity.x) > 1000 else {
                animaciaPozicii()
                return
            }

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5) {
                let translatedCenterX = self.initialCenter.x + (self.bounds.width * (velocity.x >= 0 ? 1 : -1))
                let translatedCenterY = self.initialCenter.y
                self.topView.center = .init(x: translatedCenterX, y: translatedCenterY)

                var rotationAngle: CGFloat = .pi / 16
                rotationAngle *= velocity.x >= 0 ? 1 : -1
                self.topView.transform = .init(rotationAngle: rotationAngle)

                self.bottomView.transform = .identity
            } completion: { _ in
                self.podgotovitKNextKarte()
                self.isInProgress = false
            }

        default:
            break
        }
    }

    @objc func obnovitVid() {

        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        currentIndex = 0

        topView = cardView1
        bottomView = cardView2

        [topView, bottomView].forEach {
            $0.center = initialCenter
            $0.bounds.size = cardViewSize
        }
        topView.transform = .identity
        bottomView.transform = .init(scaleX: initialScale, y: initialScale)

        bringSubviewToFront(topView)

        obnovitDatyKart()
    }

    @objc func kartaNazhata() {
        guard let card = currentCard else { return }
        didVibranaKarta?(card)
    }
}

extension SportivinieKartiSwipeKartiVide: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
