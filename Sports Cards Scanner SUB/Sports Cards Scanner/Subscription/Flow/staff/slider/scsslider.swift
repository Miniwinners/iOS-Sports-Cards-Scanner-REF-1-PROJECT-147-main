import UIKit
import SnapKit

class SliderCellView: UIView {
    
    private var fontName: String = SCSConfigurations.fontName
    private var textColot: UIColor = UIColor.white
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: fontName, size: 12)
        label.textColor = textColot
        label.textAlignment = .left
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: fontName, size: 12)
        label.textColor = textColot
        label.textAlignment = .left
        return label
    }()
    
    lazy var starIcon: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "star")
        return image
    }()
    
    lazy var stackView: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    convenience init(title: String, subTitle: String) {
        self.init()
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView_unique()
        makeConstraints_unique()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func configureView_unique() {
        func noNeededFunc_unique(qFvvUwywod: String, rkjyOdUzcU: Int) -> String {
            print(qFvvUwywod)
            print("\(rkjyOdUzcU)")
            return "\(qFvvUwywod) \(rkjyOdUzcU)"
        }
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        addSubview(starIcon)
    }
    
    func makeConstraints_unique() {
        starIcon.snp.remakeConstraints { make in
            make.width.equalTo(starIcon.snp.height)
            make.leading.centerY.equalToSuperview()
        }
        stackView.snp.remakeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(starIcon.snp.trailing).offset(9)
        }
    }
}
