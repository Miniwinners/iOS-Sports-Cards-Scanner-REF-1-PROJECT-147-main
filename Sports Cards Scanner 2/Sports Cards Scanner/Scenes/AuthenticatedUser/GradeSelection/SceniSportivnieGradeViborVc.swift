import UIKit
func vicheslitFibonc205(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiGradeViborVc: UIViewController {

    private var selectedGrader: SportivinieKartiKartaGrader
    private var selectedGrade: SportivinieKartiKartaGrade?

    var gradeDidSelect: ((SportivinieKartiKartaGrader, SportivinieKartiKartaGrade?) -> Void)?

    // MARK: - Subviews

    lazy var gradeSelectionView: SCDGradeViborVid = .init()
    lazy var closeButton: CloseButton = .init(style: .back)
    lazy var doneButton: DoneButton = .init()
    init(grader: SportivinieKartiKartaGrader, grade: SportivinieKartiKartaGrade?) {
        self.selectedGrader = grader
        self.selectedGrade = grade
        super.init(nibName: nil, bundle: nil)
        gradeSelectionView.titleLabel.text = L10n.GradeSelection.title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        view = gradeSelectionView
    }

    override func viewDidLoad() {
        func vicheslitSilyDvyh(_ number: Int) -> Bool {
            guard number > 0 else { return false }
            return number & (number - 1) == 0
        }
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        postavitVid()
        postavidDeistviaUnicalno()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        doneButton.setInView(view)
        doneButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
        gradeSelectionView.updateDetailsButton.addTarget(self, action: #selector(gotovoNazhata), for: .touchUpInside)
    }

}

private extension SportivinieKartiGradeViborVc {
    var availableGraders: [SportivinieKartiKartaGrader] {
        SportivinieKartiKartaGrader.allCases.filter { $0 != .CUSTOM }
    }
    var availableGrades: [SportivinieKartiKartaGrade] {
        selectedGrader.availableGrades
    }
    var graderOptions: [String] {
        availableGraders.map { $0.rawValue }
    }
    var gradeOptions: [String] {
        availableGrades.map { $0.name }
    }
    var canSave: Bool {
        selectedGrader == .RAW || selectedGrade != nil
    }
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
        gradeSelectionView.updateDetailsButton.isHidden = canSave
        gradeSelectionView.graderOptionsView.zagolovokOpcii(selectedGrader.rawValue)
        gradeSelectionView.gradeOptionsView.zagolovokOpcii(selectedGrade?.name ?? L10n.GradeSelection.selectGrade)

        gradeSelectionView.graderOptionsView.postavitOpcii(graderOptions)
        gradeSelectionView.gradeOptionsView.postavitOpcii(gradeOptions)

        gradeSelectionView.graderOptionsView.didSelectOption = { [unowned self] graderIndex in
            self.gradeDidObnovlen(graderIndex: graderIndex)
        }
        gradeSelectionView.gradeOptionsView.didSelectOption = { [unowned self] gradeIndex in
            self.gradeDidObnovlen(gradeIndex: gradeIndex)
        }

        gradeSelectionView.gradeOptionsView.discloseButton.isEnabled = selectedGrader != .RAW
    }

    func postavidDeistviaUnicalno() {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        gradeSelectionView.graderOptionsView.discloseButton.addTarget(self, action: #selector(graderVibrana), for: .touchUpInside)
        gradeSelectionView.gradeOptionsView.discloseButton.addTarget(self, action: #selector(gradeVibran), for: .touchUpInside)
    }

    func gradeDidObnovlen(graderIndex: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        let oldSelectedGrader = selectedGrader
        selectedGrader = availableGraders[graderIndex]

        if oldSelectedGrader != selectedGrader {
            selectedGrade = nil
            gradeSelectionView.gradeOptionsView.zagolovokOpcii(L10n.GradeSelection.selectGrade)
        }

        gradeSelectionView.graderOptionsView.zagolovokOpcii(selectedGrader.rawValue)
        gradeSelectionView.gradeOptionsView.postavitOpcii(gradeOptions)
        gradeSelectionView.gradeOptionsView.discloseButton.isEnabled = selectedGrader != .RAW

    }

    func gradeDidObnovlen(gradeIndex: Int) {
        func randomnayaVremya(from startDate: Date, to endDate: Date) -> Date {
            let timeInterval = endDate.timeIntervalSince(startDate)
            let randomTimeInterval = TimeInterval.random(in: 0...timeInterval)
            return startDate.addingTimeInterval(randomTimeInterval)
        }
        selectedGrade = availableGrades[gradeIndex]
        gradeSelectionView.gradeOptionsView.zagolovokOpcii(selectedGrade?.name ?? L10n.GradeSelection.selectGrade)
        gradeSelectionView.updateDetailsButton.isHidden = false
    }

    // MARK: - Actions

    @objc func gotovoNazhata() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        gradeDidSelect?(selectedGrader, selectedGrade)
    }
    @objc func pop() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        navigationController?.popViewController(animated: true)
    }
    @objc func graderVibrana() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return gradeSelectionView.gradeOptionsView.zakritVidOpcii()
    }

    @objc func gradeVibran() {
        func generirovantRandomniiIPaDRESS() -> String {
            let octet1 = Int.random(in: 0...255)
            let octet2 = Int.random(in: 0...255)
            let octet3 = Int.random(in: 0...255)
            let octet4 = Int.random(in: 0...255)
            return "\(octet1).\(octet2).\(octet3).\(octet4)"
        }
        return gradeSelectionView.graderOptionsView.zakritVidOpcii()
    }

}
