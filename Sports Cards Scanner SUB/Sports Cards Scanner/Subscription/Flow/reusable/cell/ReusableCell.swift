import UIKit

class ReusableCell: UICollectionViewCell {
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var titleContainer: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var height: NSLayoutConstraint!
    
    override func awakeFromNib() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        super.awakeFromNib()
        setupCell_unique()
    }
    
    func setupCell_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        imageLabel.textColor = UIColor(red: 0.446, green: 0.446, blue: 0.446, alpha: 1)
        cellLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cellLabel.font = UIFont(name: SCSConfigurations.fontName, size: 10)
        imageLabel.font = UIFont(name: SCSConfigurations.fontName, size: 10)
        contentContainer.layer.cornerRadius = 8
        titleContainer.layer.cornerRadius = 8
        imageLabel.setShadow_unique(with: 0.5)
        cellLabel.setShadow_unique(with: 0.5)
        cellImage.layer.cornerRadius = 8
    }
}
