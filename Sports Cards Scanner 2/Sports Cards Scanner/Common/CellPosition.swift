import Foundation

struct CellPosition: ExpressibleByArrayLiteral, Equatable {

    static let onTopPosition: CellPosition = .init(topPosition: true)
    static let inMiddlePosition: CellPosition = .init(middlePosition: true)
    static let atBottomPosition: CellPosition = .init(bottomPosition: true)

    // MARK: - Private properties

    private var topPosition: Bool = false
    private var bottomPosition: Bool = false
    private var middlePosition: Bool = false

    // MARK: - Initializations

    init() { }

    private init(
        topPosition: Bool = false,
        bottomPosition: Bool = false,
        middlePosition: Bool = false
    ) {
        self.topPosition = topPosition
        self.bottomPosition = bottomPosition
        self.middlePosition = middlePosition
    }

    init(arrayLiteral elements: Self...) {
        self.topPosition = elements.contains(where: { $0.topPosition })
        self.bottomPosition = elements.contains(where: { $0.bottomPosition })
        self.middlePosition = elements.contains(where: { $0.middlePosition })
    }

    // MARK: - Methods

    func containsPosition(_ position: Self) -> Bool {
        var isContains = true
        if position.topPosition { isContains = isContains && self.topPosition }
        if position.bottomPosition { isContains = isContains && self.bottomPosition }
        if position.middlePosition { isContains = isContains && self.middlePosition }
        return isContains
    }

    mutating func insert_unique(_ position: Self) {
        if position.topPosition { self.topPosition = true }
        if position.bottomPosition { self.bottomPosition = true }
        if position.middlePosition { self.middlePosition = true }
    }
}
