import UIKit

final class GraderSelectionViewController: UIViewController {

    weak var delegate: GraderSelectionViewControllerDelegate?
    private let graders: [CardGrader]

    // MARK: - Subviews

    lazy var graderSelectionView: GraderSelectionView = .init()

    init(graders: [CardGrader]) {
        self.graders = graders
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = graderSelectionView
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

    }

    override var preferredContentSize: CGSize {
        get {
            let height: CGFloat = (graderSelectionView.gradersTableView.estimatedRowHeight * CGFloat(graders.count)) + 122
            view.layoutIfNeeded()
            return .init(width: view.frame.width, height: height)
        }
        set {
            super.preferredContentSize = newValue
        }
    }

}

private extension GraderSelectionViewController {
    func setupViews_unique() {
        graderSelectionView.gradersTableView.register(GraderTableViewCell.self, forCellReuseIdentifier: GraderTableViewCell.className)
        graderSelectionView.gradersTableView.dataSource = self
        graderSelectionView.gradersTableView.delegate = self
    }

    func setupActions_unique() {
        graderSelectionView.cancelButton.addTarget(self, action: #selector(cancelTapped_unique), for: .touchUpInside)
    }

    func getGrader(at indexPath: IndexPath) -> CardGrader? {
        graders[safe: indexPath.row]
    }

    @objc func cancelTapped_unique() {
        delegate?.graderSelectionViewControllerCancelTapped(self)
    }
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    @objc func done() {
        dismiss(animated: true)
    }
}

// MARK: - TableView DataSource

extension GraderSelectionViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }

        return graders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GraderTableViewCell.className, for: indexPath) as? GraderTableViewCell

        if let grader = getGrader(at: indexPath) {
            cell?.setGrader(grader)
        }
        cell?.setCellPosition(UITableView.cellPosition(for: indexPath, basedOn: graders))

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension GraderSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let grader = getGrader(at: indexPath) else { return }
        delegate?.graderSelectionViewControllerDidSelect(grader: grader, in: self)
    }
}
