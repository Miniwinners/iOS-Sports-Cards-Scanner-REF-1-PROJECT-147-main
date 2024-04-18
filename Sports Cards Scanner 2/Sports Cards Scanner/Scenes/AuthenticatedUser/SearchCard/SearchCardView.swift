import UIKit
import SnapKit

final class SearchCardView: UIView {

    lazy var backView: UIView = { view in
        view.setupBackView()
       return view
    }(UIView())

    lazy var searchTextField: CommonTextField = { textField in
        textField.borderStyle = .none
        textField.font = .font(.interRegular, size: 16)
        textField.backgroundColor = .backColor
        textField.cornerRadius = 12
        textField.placeholder = L10n.SearchCard.Search.placeholder
        textField.rightViewMode = .always
        textField.trailingPadding = 48
        textField.returnKeyType = .search
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }(CommonTextField())

    var searchImageView: UIImageView?

    lazy var loadingIndicatorView: UIActivityIndicatorView = { indicator in
        indicator.tintColor = .labelColor
        indicator.hidesWhenStopped = true
        return indicator
    }(UIActivityIndicatorView(style: .medium))

    lazy var noResultsView: CommonMessageView = { view in
        view.setMessageTitle(L10n.SearchCard.Error.tryAgain)
        return view
    }(CommonMessageView())

    lazy var searchTableView: UITableView = { tableView in
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.contentInset.bottom = 20
        tableView.estimatedRowHeight = 400
        return tableView
    }(UITableView())

    convenience init() {
        self.init(frame: .zero)
        setupSubviews_unique()
    }

    func setNoResultsView(visible: Bool) {
        searchTableView.isUserInteractionEnabled = !visible
        noResultsView.isHidden = !visible
    }

    func setLoading(_ isLoading: Bool) {
        searchImageView?.isHidden = isLoading
        if isLoading {
            loadingIndicatorView.startAnimating()
        } else {
            loadingIndicatorView.stopAnimating()
        }
    }

}

private extension SearchCardView {
    func setupSubviews_unique() {
        backgroundColor = .clear
        addSubview(backView)
        backView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.horizontalEdges.bottom.equalToSuperview()
        }

        backView.addSubviews(searchTextField, searchTableView, noResultsView)
        setupSearchTextField()
        searchTextField.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(62)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        noResultsView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(20)
        }

        setNoResultsView(visible: false)

        searchTableView.isUserInteractionEnabled = false
    }

    func setupSearchTextField() {
        let imageView = searchTextField.setRightImage_unique(
            Images.search.image,
            paddings: .init(top: 0, left: 8, bottom: 0, right: 16)
        )
        searchTextField.rightView?.addSubview(loadingIndicatorView)
        loadingIndicatorView.snp.makeConstraints {
            $0.center.equalTo(imageView)
        }

        searchImageView = imageView
    }
}
