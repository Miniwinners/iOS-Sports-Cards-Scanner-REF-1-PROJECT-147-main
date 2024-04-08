import UIKit

final class ScanCardViewController: UIViewController {

    weak var delegate: ScanCardViewControllerDelegate?
    private let scanCardService: ScanCardService
    private let detectCardService: DetectCardService

    private let categories: [CardCategory]
    private var selectedCategory: CardCategory

    private var preparationTask: Task<(), Never>?
    private var captureCardTask: Task<(), Never>?

    private var isAuthorizationChecked = false

    private var gradeType: GradeType = .raw

    // MARK: - Subviews

    lazy var scanCardView: ScanCardView = .init()

    lazy var generator = UINotificationFeedbackGenerator()

    init(
        scanCardService: ScanCardService = .init(),
        cardCategoriesManager: CardCategoriesManager = .shared,
        detectCardService: DetectCardService = .shared
    ) {
        self.scanCardService = scanCardService
        self.detectCardService = detectCardService
        self.categories = cardCategoriesManager.enabledCardCategories
        self.selectedCategory = cardCategoriesManager.enabledCardCategories.first!
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = scanCardView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scanCardService.setupCaptureSession()
        setupViews_unique()
        setupActions_unique()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        checkAuthorizationIfNeeded()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        cancelTasks()
        scanCardService.stopRunning()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    func restartScanning() {
        Task { @MainActor in
            await scanCardService.startRunning()
            scanCardView.capturedImageView.image = nil
        }
    }

}

private extension ScanCardViewController {
    func setupViews_unique() {
        scanCardView.selectCategoryButton.cardCategory = selectedCategory

        scanCardView.categoriesTableView.register(SelectableCardCategoryTableViewCell.self, forCellReuseIdentifier: SelectableCardCategoryTableViewCell.className)
        scanCardView.categoriesTableView.dataSource = self
        scanCardView.categoriesTableView.delegate = self

        if let captureSession = scanCardService.captureSession {
            scanCardView.setupCameraPreview(with: captureSession)
        }

        scanCardView.updateGradeType(gradeType)
    }

    func setupActions_unique() {
        scanCardView.closeButton.addTarget(self, action: #selector(closeTapped_unique), for: .touchUpInside)
        scanCardView.captureButton.addTarget(self, action: #selector(captureTapped), for: .touchUpInside)
        scanCardView.noAuthorizationView.openSettingsButton.addTarget(self, action: #selector(openSettingsTapped), for: .touchUpInside)
        scanCardView.selectCategoryButton.addTarget(self, action: #selector(selectCategoryTapped), for: .touchUpInside)
        scanCardView.gradeTypeButton.addTarget(self, action: #selector(gradeTypeTapped), for: .touchUpInside)
    }

    func checkAuthorizationIfNeeded() {
        if isAuthorizationChecked { return }

        preparationTask = Task { @MainActor in
            defer { isAuthorizationChecked = true }

            if await scanCardService.isAuthorized {
                if Task.isCancelled { return }
                await scanCardService.startRunning()
            } else {
                scanCardView.showNoAuthorization()
            }
        }
    }

    func cancelTasks() {
        captureCardTask?.cancel()
        preparationTask?.cancel()
    }

    func cropImage(data imageData: Data) -> Data? {
        let uiImage = UIImage(data: imageData)
        let uiImageSize = uiImage?.size ?? scanCardView.bounds.size

        let screenFrame = scanCardView.bounds

        let imageToScreenScale = min(uiImageSize.width / screenFrame.width, uiImageSize.height / screenFrame.height)

        let screenTranslateX = max(0, (uiImageSize.width - screenFrame.width * imageToScreenScale) / 2)
        let screenTranslateY = max(0, (uiImageSize.height - screenFrame.height * imageToScreenScale) / 2)
        let scaledScreenFrame = screenFrame
            .applying(.init(scaleX: imageToScreenScale, y: imageToScreenScale))
            .applying(.init(translationX: screenTranslateX, y: screenTranslateY))

        let captureAreaFrame = scanCardView.captureFrameView.bounds
        let captureAreaTranslateX = max(0, (screenFrame.width - captureAreaFrame.width) * imageToScreenScale / 2)
        let captureAreaTranslateY = max(0, (screenFrame.height - captureAreaFrame.height) * imageToScreenScale / 2)
        let scaledCaptureAreaFrame = captureAreaFrame
            .applying(.init(scaleX: imageToScreenScale, y: imageToScreenScale))
            .applying(.init(translationX: captureAreaTranslateX, y: captureAreaTranslateY))

        let croppedImageData = uiImage?
            .croppedImage(in: scaledScreenFrame)
            .croppedImage(in: scaledCaptureAreaFrame)
            .convertedToJPEG(.lowest) ?? imageData

        return croppedImageData
    }

    // MARK: - Actions

    @objc func closeTapped_unique() {
        delegate?.scanCardViewControllerCloseTapped(self)
    }

    @objc func captureTapped() {
        generator.notificationOccurred(.success)

        captureCardTask = Task { @MainActor in
            do {
                let imageData = try await scanCardService.captureImage()
                try Task.checkCancellation()

                guard let croppedImageData = detectCardService.cropImage(
                    data: imageData,
                    from: scanCardView.bounds,
                    to: scanCardView.captureFrameView.bounds
                ) else { return }

                let detectedCardData = try? await detectCardService.detectCard(
                    from: croppedImageData
                )

                scanCardView.capturedImageView.image = UIImage(data: imageData)
                scanCardService.stopRunning()

                let scannedCard = ScannedCard(encodedCardImage: detectedCardData ?? croppedImageData, cardCategory: selectedCategory)
                delegate?.scanCardViewControllerDidCapture(card: scannedCard, self)
            } catch {
                return
            }
        }
    }

    @objc func openSettingsTapped() {
        delegate?.scanCardViewControllerOpenSettings(self)
    }

    @objc func selectCategoryTapped() {
        if scanCardView.categoriesTableView.isHidden {
            scanCardView.showCardCategories(count: categories.count, animated: true)
        } else {
            scanCardView.hideCardCategories(animated: true)
        }
    }

    @objc func gradeTypeTapped() {
        gradeType = gradeType.reversed
        scanCardView.updateGradeType(gradeType)
    }
}

// MARK: - TableView Data Source

extension ScanCardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: SelectableCardCategoryTableViewCell.className, for: indexPath) as? SelectableCardCategoryTableViewCell

        if let category = getCardCategory(at: indexPath) {
            categoryCell?.setCategory(category)
            categoryCell?.setSelected(category == selectedCategory)

            let extraSpace = scanCardView.tableViewCellExtraSpace
            categoryCell?.setExtraSpace(category == categories.first ? extraSpace : 0, to: .top)
            categoryCell?.setExtraSpace(category == categories.last ? extraSpace : 0, to: .bottom)
        }

        return categoryCell ?? UITableViewCell()
    }

    private func getCardCategory(at indexPath: IndexPath) -> CardCategory? {
        categories[safe: indexPath.row]
    }

    private func getIndexPath(of category: CardCategory) -> IndexPath? {
        guard let index = categories.firstIndex(of: category) else { return nil }
        return IndexPath(row: index, section: 0)
    }

    private func setCellSelected(_ selected: Bool, at indexPath: IndexPath) {
        guard let categoryCell = scanCardView.categoriesTableView.cellForRow(at: indexPath) as? SelectableCardCategoryTableViewCell
        else { return }

        categoryCell.setSelected(selected)
    }
}

// MARK: - TableView Delegate

extension ScanCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        defer { scanCardView.hideCardCategories(animated: true) }

        guard let newSelectedCategory = getCardCategory(at: indexPath) else { return }

        if let oldSelectedCellIndexPath = getIndexPath(of: selectedCategory) {
            setCellSelected(false, at: oldSelectedCellIndexPath)
        }
        setCellSelected(true, at: indexPath)

        selectedCategory = newSelectedCategory
        scanCardView.selectCategoryButton.cardCategory = newSelectedCategory
    }
}
