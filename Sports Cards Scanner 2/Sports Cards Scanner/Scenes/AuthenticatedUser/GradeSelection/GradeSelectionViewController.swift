import UIKit

final class GradeSelectionViewController: UIViewController {

    private var selectedGrader: CardGrader
    private var selectedGrade: CardGrade?

    var gradeDidSelect: ((CardGrader, CardGrade?) -> Void)?

    // MARK: - Subviews

    lazy var gradeSelectionView: GradeSelectionView = .init()
    lazy var closeButton: CloseButton = .init(style: .back)
    lazy var doneButton: DoneButton = .init()
    init(grader: CardGrader, grade: CardGrade?) {
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
        view = gradeSelectionView
    }

    override func viewDidLoad() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupViews_unique()
        setupActions_unique()
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        doneButton.setInView(view)
        doneButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
        gradeSelectionView.updateDetailsButton.addTarget(self, action: #selector(doneTapped_unique), for: .touchUpInside)
    }

}

private extension GradeSelectionViewController {
    var availableGraders: [CardGrader] {
        CardGrader.allCases.filter { $0 != .CUSTOM }
    }
    var availableGrades: [CardGrade] {
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

    func setupViews_unique() {

        gradeSelectionView.updateDetailsButton.isHidden = canSave
        gradeSelectionView.graderOptionsView.setOptionTitle(selectedGrader.rawValue)
        gradeSelectionView.gradeOptionsView.setOptionTitle(selectedGrade?.name ?? L10n.GradeSelection.selectGrade)

        gradeSelectionView.graderOptionsView.setOptions(graderOptions)
        gradeSelectionView.gradeOptionsView.setOptions(gradeOptions)

        gradeSelectionView.graderOptionsView.didSelectOption = { [unowned self] graderIndex in
            self.graderDidUpdate(graderIndex: graderIndex)
        }
        gradeSelectionView.gradeOptionsView.didSelectOption = { [unowned self] gradeIndex in
            self.gradeDidUpdate(gradeIndex: gradeIndex)
        }

        gradeSelectionView.gradeOptionsView.discloseButton.isEnabled = selectedGrader != .RAW
    }

    func setupActions_unique() {
        gradeSelectionView.graderOptionsView.discloseButton.addTarget(self, action: #selector(graderSelectionTapped), for: .touchUpInside)
        gradeSelectionView.gradeOptionsView.discloseButton.addTarget(self, action: #selector(gradeSelectionTapped), for: .touchUpInside)
    }

    func graderDidUpdate(graderIndex: Int) {
        let oldSelectedGrader = selectedGrader
        selectedGrader = availableGraders[graderIndex]

        if oldSelectedGrader != selectedGrader {
            selectedGrade = nil
            gradeSelectionView.gradeOptionsView.setOptionTitle(L10n.GradeSelection.selectGrade)
        }

        gradeSelectionView.graderOptionsView.setOptionTitle(selectedGrader.rawValue)
        gradeSelectionView.gradeOptionsView.setOptions(gradeOptions)
        gradeSelectionView.gradeOptionsView.discloseButton.isEnabled = selectedGrader != .RAW

    }

    func gradeDidUpdate(gradeIndex: Int) {
        selectedGrade = availableGrades[gradeIndex]
        gradeSelectionView.gradeOptionsView.setOptionTitle(selectedGrade?.name ?? L10n.GradeSelection.selectGrade)
        gradeSelectionView.updateDetailsButton.isHidden = false
    }

    // MARK: - Actions

    @objc func doneTapped_unique() {
        gradeDidSelect?(selectedGrader, selectedGrade)
    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    @objc func graderSelectionTapped() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return gradeSelectionView.gradeOptionsView.closeOptionsView()
    }

    @objc func gradeSelectionTapped() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return gradeSelectionView.graderOptionsView.closeOptionsView()
    }

}
