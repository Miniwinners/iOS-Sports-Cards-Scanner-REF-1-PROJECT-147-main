import UIKit

final class SwipeableCardsView: UIView {

    var didSelectCard: ((CardRepresentable) -> Void)?

    private var oldBounds: CGRect = .zero
    override var bounds: CGRect {
        didSet { boundsDidUpdate() }
    }

    private var currentIndex: Int = 0

    var cards: [CardRepresentable] = []
    private var currentCard: CardRepresentable? { cards[safe: currentIndex] }
    private var nextCard: CardRepresentable? { cards[safe: currentIndex + 1] }

    private var isInProgress = false

    // MARK: - Subviews

    private lazy var topView: SwipeableCardButton = cardView1
    private lazy var bottomView: SwipeableCardButton = cardView2

    private lazy var cardView1: SwipeableCardButton = { button in
        button.cornerRadius = 12
        return button
    }(SwipeableCardButton())

    private lazy var cardView2: SwipeableCardButton = { button in
        button.cornerRadius = 12
        return button
    }(SwipeableCardButton())

    private lazy var resetButton: UIButton = { button in
        button.setTitle(L10n.Common.reset, for: .normal)
        button.titleLabel?.font = .font(.interMedium, size: 20)
        return button
    }(UIButton(type: .system))

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
        setupActions_unique()
        setupGesture_unique()
    }

    func reloadCardsData() {
        topView.isHidden = currentCard.isNil
        bottomView.isHidden = nextCard.isNil

        topView.setCard(currentCard)
        bottomView.setCard(nextCard)
    }

}

private extension SwipeableCardsView {
    var minInsets: UIEdgeInsets { .init(top: 0, left: 0, bottom: 25, right: 0) }

    var maxWidth: CGFloat { bounds.width  - (minInsets.left + minInsets.right)}
    var maxHeight: CGFloat { bounds.height - (minInsets.top + minInsets.bottom) }

    var initialCenter: CGPoint { .init(x: bounds.width / 2, y: bounds.height / 2) }

    var initialScale: CGFloat { 0.6 }

    var cardViewSize: CGSize {
        var itemWidth = maxWidth
        var photoWidth = itemWidth - 24
        var photoHeight = photoWidth / SwipeableCardButton.photoRatio
        var itemHeight = photoHeight + 78

        if itemHeight <= maxHeight {
            return .init(width: itemWidth, height: itemHeight)
        }

        itemHeight = maxHeight
        photoHeight = itemHeight - 78
        photoWidth = photoHeight * SwipeableCardButton.photoRatio
        itemWidth = photoWidth + 24

        return .init(width: itemWidth, height: itemHeight)
    }

    func setupSubviews_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        addSubviews(resetButton, cardView2, cardView1)
    }

    func setupActions_unique() {
        cardView1.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)
        cardView2.addTarget(self, action: #selector(cardTapped), for: .touchUpInside)

        resetButton.addTarget(self, action: #selector(resetCardsView), for: .touchUpInside)
    }

    func setupGesture_unique() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(cardDidPan(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self

        addGestureRecognizer(panGesture)
    }

    func boundsDidUpdate() {
        if bounds.width == oldBounds.width { return }
        oldBounds = bounds
//        topView.backgroundColor = .blue
//        bottomView.backgroundColor = .yellow
        [topView, bottomView].forEach {
            $0.center = initialCenter
            $0.bounds.size = cardViewSize
        }
        bottomView.transform = .init(scaleX: initialScale, y: initialScale)

        resetButton.sizeToFit()
        resetButton.center = initialCenter
    }

    func animateToInitialPosition() {
        UIView.animate(withDuration: 0.2) {
            self.topView.center = self.initialCenter
            self.topView.transform = .identity

            self.bottomView.transform = .init(scaleX: self.initialScale, y: self.initialScale)
        } completion: { _ in
            self.isInProgress = false
        }
    }

    func prepareForNextCard() {
        currentIndex += 1

        (topView, bottomView) = (bottomView, topView)

        bringSubviewToFront(topView)

        bottomView.center = initialCenter
        bottomView.bounds.size = cardViewSize
        bottomView.transform = .init(scaleX: initialScale, y: initialScale)
        bottomView.setCard(nextCard)
        bottomView.isHidden = nextCard.isNil
    }

    // MARK: - Actions

    @objc func cardDidPan(_ sender: UIPanGestureRecognizer) {
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
                animateToInitialPosition()
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
                self.prepareForNextCard()
                self.isInProgress = false
            }

        default:
            break
        }
    }

    @objc func resetCardsView() {
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

        reloadCardsData()
    }

    @objc func cardTapped() {
        guard let card = currentCard else { return }
        didSelectCard?(card)
    }
}

extension SwipeableCardsView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}
