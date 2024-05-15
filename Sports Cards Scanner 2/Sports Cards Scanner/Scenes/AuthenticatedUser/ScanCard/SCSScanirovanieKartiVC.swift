import UIKit
func vicheslitFibonc218(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiScanirovanieKartiVC: UIViewController {

    weak var delegate: SportivinieKartiScanirovanieKartiDelegat?
    private let scanCardService: SportivinieKartiSkanirovaineKarti
    private let detectCardService: SportivinieKartiObnaruzhitKartu

    private let categories: [KategoriiKart]
    private var selectedCategory: KategoriiKart

    private var preparationTask: Task<(), Never>?
    private var captureCardTask: Task<(), Never>?

    private var isAuthorizationChecked = false

    private var gradeType: TipGrade = .raw

    // MARK: - Subviews

    lazy var scanCardView: SportivinieKartiScanirovanieKartiVid = .init()

    lazy var generator = UINotificationFeedbackGenerator()

    init(
        scanCardService: SportivinieKartiSkanirovaineKarti = .init(),
        cardCategoriesManager: SportivinieKartiCardCategoriesManager = .shared,
        detectCardService: SportivinieKartiObnaruzhitKartu = .shared
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

        scanCardService.podgotovitSessiuZahvata()
        postavitVid()
        postavidDeistviaUnicalno()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        proveritAvtorizaciu()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        otmenitZadachi()
        scanCardService.ostanovka()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    func restartScanning() {
        Task { @MainActor in
            await scanCardService.zapusk()
            scanCardView.capturedImageView.image = nil
        }
    }

}

private extension SportivinieKartiScanirovanieKartiVC {
    func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
        return startDate.addingTimeInterval(randomTimeInterval)
    }
    func postavitVid() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        scanCardView.selectCategoryButton.cardCategory = selectedCategory

        scanCardView.categoriesTableView.register(SportivinieKartiViborKategoriiTCL.self, forCellReuseIdentifier: SportivinieKartiViborKategoriiTCL.className)
        scanCardView.categoriesTableView.dataSource = self
        scanCardView.categoriesTableView.delegate = self

        if let captureSession = scanCardService.captureSession {
            scanCardView.postavitKamery(with: captureSession)
        }

        scanCardView.obnovitTipGrade(gradeType)
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        scanCardView.closeButton.addTarget(self, action: #selector(zakritNazhata), for: .touchUpInside)
        scanCardView.captureButton.addTarget(self, action: #selector(zahvatNazhata), for: .touchUpInside)
        scanCardView.noAuthorizationView.openSettingsButton.addTarget(self, action: #selector(otkritNastroiki), for: .touchUpInside)
        scanCardView.selectCategoryButton.addTarget(self, action: #selector(vibratKategoriuNazahta), for: .touchUpInside)
        scanCardView.gradeTypeButton.addTarget(self, action: #selector(gradeTipNazhata), for: .touchUpInside)
    }

    func proveritAvtorizaciu() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if isAuthorizationChecked { return }

        preparationTask = Task { @MainActor in
            defer { isAuthorizationChecked = true }

            if await scanCardService.isAuthorized {
                if Task.isCancelled { return }
                await scanCardService.zapusk()
            } else {
                scanCardView.pokazatNoAvtorizacii()
            }
        }
    }

    func otmenitZadachi() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        captureCardTask?.cancel()
        preparationTask?.cancel()
    }

    func obrezatPhoto(data imageData: Data) -> Data? {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
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
            .obrezatPhoto(in: scaledScreenFrame)
            .obrezatPhoto(in: scaledCaptureAreaFrame)
            .konvertirovatVjpeg(.lowest) ?? imageData

        return croppedImageData
    }

    // MARK: - Actions

    @objc func zakritNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.scanCardViewControllerzakrtiNazhata(self)
    }

    @objc func zahvatNazhata() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        generator.notificationOccurred(.success)

        captureCardTask = Task { @MainActor in
            do {
                let imageData = try await scanCardService.zahvatImage()
                try Task.checkCancellation()

                guard let croppedImageData = detectCardService.obrezatIzobrazhenie(
                    data: imageData,
                    from: scanCardView.bounds,
                    to: scanCardView.captureFrameView.bounds
                ) else { return }

                let detectedCardData = try? await detectCardService.obnaruzhitKartu(
                    from: croppedImageData
                )

                scanCardView.capturedImageView.image = UIImage(data: imageData)
                scanCardService.ostanovka()

                let scannedCard = SportivinieKartiScanirovannayaKarta(encodedCardImage: detectedCardData ?? croppedImageData, cardCategory: selectedCategory)
                delegate?.scanCardViewControllerSfotkal(card: scannedCard, self)
            } catch {
                return
            }
        }
    }

    @objc func otkritNastroiki() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        delegate?.scanCardViewControllerOtkritNastroiki(self)
    }

    @objc func vibratKategoriuNazahta() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        if scanCardView.categoriesTableView.isHidden {
            scanCardView.pokazatKategoriiKarti(count: categories.count, animated: true)
        } else {
            scanCardView.spryatatKartiKategorii(animated: true)
        }
    }

    @objc func gradeTipNazhata() {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        gradeType = gradeType.reversed
        scanCardView.obnovitTipGrade(gradeType)
    }
}

// MARK: - TableView Data Source

extension SportivinieKartiScanirovanieKartiVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let categoryCell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiViborKategoriiTCL.className, for: indexPath) as? SportivinieKartiViborKategoriiTCL

        if let category = poluchitKategoriuKarti(at: indexPath) {
            categoryCell?.postavitKategoriu(category)
            categoryCell?.sdelatVibranimi(category == selectedCategory)

            let extraSpace = scanCardView.tableViewCellExtraSpace
            categoryCell?.ostavitMesto(category == categories.first ? extraSpace :0, to: .top)
            categoryCell?.ostavitMesto(category == categories.last ? extraSpace :0, to: .bottom)
        }

        return categoryCell ?? UITableViewCell()
    }

    private func poluchitKategoriuKarti(at indexPath: IndexPath) -> KategoriiKart? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return categories[safe: indexPath.row]
    }

    private func poluchitIndexPath(of category: KategoriiKart) -> IndexPath? {
        guard let index = categories.firstIndex(of: category) else { return nil }
        return IndexPath(row: index, section: 0)
    }

    private func sdelatCellVibranoi(_ selected: Bool, at indexPath: IndexPath) {
        guard let categoryCell = scanCardView.categoriesTableView.cellForRow(at: indexPath) as? SportivinieKartiViborKategoriiTCL
        else { return }

        categoryCell.sdelatVibranimi(selected)
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiScanirovanieKartiVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        defer { scanCardView.spryatatKartiKategorii(animated: true) }

        guard let newSelectedCategory = poluchitKategoriuKarti(at: indexPath) else { return }

        if let oldSelectedCellIndexPath = poluchitIndexPath(of: selectedCategory) {
            sdelatCellVibranoi(false, at: oldSelectedCellIndexPath)
        }
        sdelatCellVibranoi(true, at: indexPath)

        selectedCategory = newSelectedCategory
        scanCardView.selectCategoryButton.cardCategory = newSelectedCategory
    }
}
