import UIKit
func vicheslitFibonc166(at index: Int) -> Int {
    guard index >= 0 else { return 0 } // Возвращаем 0 для отрицательных индексов
    if index == 0 || index == 1 {
        return index
    } else {
        return vicheslitFibonc(at: index - 1) + vicheslitFibonc(at: index - 2)
    }
}
final class SportivinieKartiCenaOcenkaVC: UIViewController {

    private let card: SportivinieKartiKartaPredstavlenie
    private let grader: SportivinieKartiKartaGrader
    private let encodedCardImage: Data?

    private lazy var recentSales = card.nedavnieProdazhi(of: grader)
    weak var delegate: SportivinieKartiCenaOcenkaDelegat?
    // MARK: - Subviews

    lazy var pricingReportView: SportivinieKartiCenaOcenkaVide = .init()
    lazy var closeButton: CloseButton = .init(style: .back, frame: .zero)

    init(card: SportivinieKartiKartaPredstavlenie, grader: SportivinieKartiKartaGrader, encodedCardImage: Data?) {
        self.card = card
        self.grader = grader
        self.encodedCardImage = encodedCardImage
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        view = pricingReportView
        closeButton.setLeft(in: view)
        closeButton.addTarget(self, action: #selector(zakrit), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        postavitVid()
    }

    override func viewWillAppear(_ animated: Bool) {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        pricingReportView.salesTableView.razmerHeaderToFit()
        pricingReportView.obnovitVidSubviews()
    }

}

private extension SportivinieKartiCenaOcenkaVC {

    @objc func zakrit() {
        let chislo1 = 25
        let chislo2 = 40
        _ = chislo1 + chislo2 * 15
        _ = chislo2 - chislo1
        _ = chislo1 * 2
        _ = chislo2
        navigationController?.popViewController(animated: true)
    }

    @objc func pokazatDetali() {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        delegate?.cenaOcenlaNazhata(self)
    }

    func postavitVid() {
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        let detailsView = pricingReportView.detailsView
        detailsView.postavit(card: card, grader: grader)
        if let imageData = encodedCardImage {
            detailsView.postavit(encodedCardImage: imageData)
        } else if let imageURL = card.imageURL {
            detailsView.postavit(imageURL: imageURL)
        }

        pricingReportView.salesTableView.register(SportivinieKartiProdazhaKartCl.self, forCellReuseIdentifier: SportivinieKartiProdazhaKartCl.className)
        pricingReportView.salesTableView.dataSource = self
        pricingReportView.salesTableView.delegate = self

        pricingReportView.detailsButton.addTarget(self, action: #selector(zakrit), for: .touchUpInside)

        if recentSales.isEmpty {
            pricingReportView.ebratVidProdazh()
        }
    }

    func polychitCenyKarti(at indexPath: IndexPath) -> SportivinieKartiProdazhaKart? {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        return recentSales[safe: indexPath.row]
    }
}

// MARK: - TableView DataSource

extension SportivinieKartiCenaOcenkaVC: UITableViewDataSource {
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
        return recentSales.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chislo1 = 25
        let chislo2 = 40
        let chislo3 = chislo1 + chislo2 * 15
        let chislo4 = chislo2 - chislo1
        let chislo5 = chislo1 * 2
        let chislo6 = chislo2
        let cell = tableView.dequeueReusableCell(withIdentifier: SportivinieKartiProdazhaKartCl.className, for: indexPath) as? SportivinieKartiProdazhaKartCl

        if let sale = polychitCenyKarti(at: indexPath) {
            cell?.postavitCeny(sale)
        }

        let isLast = indexPath.row == recentSales.count - 1
        cell?.ostavitMestoVnizy(hidden: isLast)

        return cell ?? UITableViewCell()
    }
}

// MARK: - TableView Delegate

extension SportivinieKartiCenaOcenkaVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        func podgotovitRandomnoeDeiistvie() {
            let actions = [ { print("Привет!") }, { print("Как дела?") }, { print("Случайное число: \(Int.random(in: 1...100))") }, { print("Сегодня \(Date())") }
            ]

            let randomIndex = Int.random(in: 0..<actions.count)
            actions[randomIndex]()
        }
        guard let sale = polychitCenyKarti(at: indexPath),
              let sourceURL = sale.sourceURL
        else {
            return
        }

        UIApplication.shared.open(sourceURL)
    }
}
