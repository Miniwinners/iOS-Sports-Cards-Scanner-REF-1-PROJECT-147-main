import UIKit
import SnapKit
import AVFoundation

final class ScanCardView: UIView {

    private var cardCategoriesListHeightConstraint: Constraint!

    let tableViewCellExtraSpace: CGFloat = 2

    lazy var cardSideLabel: UILabel = { label in
        label.text = L10n.ScanCard.CardSide.front
        label.textColor = .white
        label.font = .font(.interBold, size: 20)
        return label
    }(UILabel())

    lazy var closeButton: UIButton = { button in
        button.setImage(Images.close.image, for: .normal)
        button.tintColor = .white
        return button
    }(UIButton(type: .system))

    lazy var gradeTypeButton: CommonButton = {
        var configuration: UIButton.Configuration = .filled()
        configuration.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        configuration.background.cornerRadius = 10
        configuration.cornerStyle = .fixed
        let appearance: CommonButton.SCSAppearance = .init(
            configuration: configuration,
            font: .font(.interMedium, size: 16),
            backgroundColors: .init(primary: .white, highlighted: .highlightColor2),
            foregroundColors: .init(primary: .labelColor, highlighted: .labelColor)
        )
        return .init(style: .custom(appearance))
    }()

    lazy var cameraPreview: UIView = .init()

    private var cameraPreviewLayer: AVCaptureVideoPreviewLayer?

    lazy var capturedImageView: UIImageView = { imageView in
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView())

    lazy var captureFrameView: UIView = { view in
        view.cornerRadius = 30
        view.borderColor = .white
        view.borderWidth = 2
        return view
    }(UIView())

    lazy var noAuthorizationView: NoCaptureAuthorizationView = .init()

    lazy var shadowView: UIView = { view in
        view.backgroundColor = .blackColor40
        return view
    }(UIView())

    lazy var selectCategoryButton: CardCategoryButton = .init()

    lazy var captureButton: UIButton = { button in
        var configuration = button.configuration ?? .filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .white
        configuration.background.strokeWidth = 4
        configuration.background.strokeColor = .white
        configuration.background.strokeOutset = 7
        button.configuration = configuration
        return button
    }(UIButton(configuration: .filled()))

    lazy var categoriesTableView: UITableView = { tableView in
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 34
        tableView.isScrollEnabled = false
        tableView.cornerRadius = 6
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondaryColor
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
        hideCardCategories(animated: false)
    }

    func setupCameraPreview(with captureSession: AVCaptureSession) {
        let cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.frame = self.frame
        cameraPreviewLayer.videoGravity = .resizeAspectFill
        cameraPreviewLayer.connection?.videoOrientation = .portrait
        cameraPreview.layer.addSublayer(cameraPreviewLayer)
        self.cameraPreviewLayer = cameraPreviewLayer
    }

    func showNoAuthorization() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        noAuthorizationView.isHidden = false
        disableCaptureButton()
    }

    func showCardCategories(count: Int, animated: Bool) {
        guard categoriesTableView.isHidden else { return }

        let finalTableViewHeight: CGFloat = (categoriesTableView.estimatedRowHeight * CGFloat(count)) + (tableViewCellExtraSpace * 2)

        categoriesTableView.isHidden = false
        categoriesTableView.layer.opacity = 0
        cardCategoriesListHeightConstraint.update(offset: finalTableViewHeight)

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.categoriesTableView.layer.opacity = 1
                self.selectCategoryButton.underlineView.layer.opacity = 0
                self.layoutIfNeeded()
            }
        } else {
            categoriesTableView.layer.opacity = 1
            selectCategoryButton.underlineView.layer.opacity = 0
        }
    }

    func hideCardCategories(animated: Bool) {
        cardCategoriesListHeightConstraint.update(offset: 0)

        if animated {
            UIView.animate(withDuration: 0.3) {
                self.categoriesTableView.layer.opacity = 0
                self.selectCategoryButton.underlineView.layer.opacity = 1
                self.layoutIfNeeded()
            } completion: { _ in
                self.categoriesTableView.isHidden = true
            }
        } else {
            categoriesTableView.layer.opacity = 0
            categoriesTableView.isHidden = true
            selectCategoryButton.underlineView.layer.opacity = 1
        }
    }

    func updateGradeType(_ type: GradeType) {
        gradeTypeButton.setButtonTitle(type.localizable)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateCaptureFrameViewMask()
        updateShadowViewMask()
        cameraPreviewLayer?.frame = self.frame
    }

}

private extension ScanCardView {
    func setupSubviews_unique() {
        backgroundColor = .black

        addSubviews(cameraPreview, capturedImageView, shadowView, cardSideLabel, captureFrameView)
        cameraPreview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        capturedImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        cardSideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
        }
        captureFrameView.snp.makeConstraints {
            $0.size.equalToSuperview().priority(.low)
            $0.top.greaterThanOrEqualTo(safeAreaLayoutGuide).inset(150)
            $0.bottom.lessThanOrEqualTo(safeAreaLayoutGuide).inset(120)
            $0.leading.greaterThanOrEqualToSuperview().inset(40)
            $0.height.equalTo(captureFrameView.snp.width).multipliedBy(1.43)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(.high)
        }

        setupCategoryViews()
        setupButtons_unique()
        setupNoAuthorizationView()
    }

    func setupCategoryViews() {
        addSubviews(selectCategoryButton, categoriesTableView)
        selectCategoryButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(90)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(189)
            $0.height.equalTo(39)
        }
        categoriesTableView.snp.makeConstraints {
            cardCategoriesListHeightConstraint = $0.height.equalTo(0).constraint
            $0.horizontalEdges.equalTo(selectCategoryButton)
            $0.top.equalTo(selectCategoryButton.snp.bottom)
        }
    }

    func setupButtons_unique() {
        addSubviews(closeButton, captureButton, gradeTypeButton)
        closeButton.snp.makeConstraints {
            $0.size.equalTo(54)
            $0.top.equalTo(safeAreaLayoutGuide).inset(90)
            $0.trailing.equalToSuperview().inset(5)
        }
        captureButton.snp.makeConstraints {
            $0.size.equalTo(67)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(20)
        }
        gradeTypeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(37)
            $0.height.equalTo(42)
        }
    }

    func setupNoAuthorizationView() {
        addSubview(noAuthorizationView)
        noAuthorizationView.snp.makeConstraints {
            $0.centerY.equalTo(captureFrameView)
            $0.horizontalEdges.equalTo(captureFrameView).inset(16)
        }
        noAuthorizationView.isHidden = true
    }

    func updateCaptureFrameViewMask() {
        let frameWidth = captureFrameView.bounds.width
        let frameHeight = captureFrameView.bounds.height
        let mutablePath = CGMutablePath()
        mutablePath.addRect(.init(x: 0, y: 0, width: 66, height: 66).insetBy(dx: -1, dy: -1))
        mutablePath.addRect(.init(x: 0, y: frameHeight - 66, width: 66, height: 66).insetBy(dx: -1, dy: -1))
        mutablePath.addRect(.init(x: frameWidth - 66, y: 0, width: 66, height: 66).insetBy(dx: -1, dy: -1))
        mutablePath.addRect(.init(x: frameWidth - 66, y: frameHeight - 66, width: 66, height: 66).insetBy(dx: -1, dy: -1))
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = .evenOdd
        captureFrameView.layer.mask = mask
    }

    func updateShadowViewMask() {
        let frame = captureFrameView.frame
        let mutablePath = CGMutablePath()
        mutablePath.addRect(self.frame)
        mutablePath.addRoundedRect(in: frame, cornerWidth: 30, cornerHeight: 30)
        let mask = CAShapeLayer()
        mask.path = mutablePath
        mask.fillRule = .evenOdd
        shadowView.layer.mask = mask
    }

    func disableCaptureButton() {
        captureButton.isEnabled = false
        if var configuration = captureButton.configuration {
            configuration.background.backgroundColorTransformer = .init({ _ in .secondaryColor })
            captureButton.configuration = configuration
        }
    }
}
