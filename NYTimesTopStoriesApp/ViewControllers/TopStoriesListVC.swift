//
//  TopStoriesListVC.swift
//  NYTimesTopStoriesApp
//
//  Created by deniz karahan on 21.09.2022.
//

import UIKit

final class TopStoriesListVC: BaseViewController<TopStoriesListVM> {
    private var menuBar = CategoryMenuBar()
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView()
    private let noDataFoundLbl = UILabel()
    private let btnRetry = UILabel()
    
    var selectedSection: NYTTopStoriesEndpoint = .home
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Stories List".local
        view.backgroundColor = .white
        applyCodeView()
   
        viewModel?.errorHandler = { [weak self] error in
            AlertUtil.showAlert(self!, withTitle: "Top Stories Error".local, andMessage: error.localizedDescription)
        }
    }
    
    private func fetchNews(isRefresh: Bool = false) {
        self.viewModel?.response?.clearNewsListToLoadNewSection()
        if !isRefresh {
            self.tableView.reloadData()
            self.tableView.separatorStyle = .none
            activityIndicator.startAnimating()
        }
        
        viewModel?.getNewCategortiesStoryList(selectedSection: self.selectedSection) { storyList in
            self.updateUI()
        }
        
        viewModel?.errorHandler = { [weak self] error in
            self?.activityIndicator.stopAnimating()
            AlertUtil.showAlert(self!, withTitle: "Top Stories Error".local, andMessage: error.localizedDescription)
        }
    }
    
    //Update UI after fetching the data from server
    private func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            guard let topStoriesList = self.viewModel?.response else { return  }
            self.tableView.separatorStyle = topStoriesList.isNewsListEmpty ? .none : .singleLine
            self.noDataFoundLbl.isHidden = !topStoriesList.isNewsListEmpty
            self.btnRetry.isHidden = !topStoriesList.isNewsListEmpty
            self.tableView.isHidden = topStoriesList.isNewsListEmpty
        }
    }
    
    private func pushDetailPage(_ data: TopStories){
        let vc = TopStoriesDetailVC.instantiate(viewModel: TopStoriesDetailVM(detailData: data))
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK : setup UI Elements
private extension TopStoriesListVC {
    func setupLabel() {
        noDataFoundLbl.isHidden = true
        noDataFoundLbl.text = "Unfortunately No Top Story Found".local
        noDataFoundLbl.textAlignment = .center
        noDataFoundLbl.textColor = .black
        noDataFoundLbl.translatesAutoresizingMaskIntoConstraints = false
        noDataFoundLbl.numberOfLines = 1
        noDataFoundLbl.font = UIFont(name: "OpenSans-ExtraBoldItalic", size: 120)
 
    }
    
    func setupLabelConstraints() {
        NSLayoutConstraint.activate([
          noDataFoundLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          noDataFoundLbl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          noDataFoundLbl.widthAnchor.constraint(equalToConstant: 300),
          noDataFoundLbl.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func setupButton() {
        btnRetry.isHidden = true
        btnRetry.text = "Try Again..".local
        btnRetry.textAlignment = .center
        btnRetry.textColor = .white
        btnRetry.backgroundColor = .black
        btnRetry.translatesAutoresizingMaskIntoConstraints = false
        btnRetry.numberOfLines = 1
        btnRetry.isEnabled = true
        btnRetry.setBorder(color: .lightGray, width: 1.0)
        btnRetry.setRadius(radius: 6.0)
        
        btnRetry.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.btnRetryTapped))
        btnRetry.addGestureRecognizer(tap)
    }
    
    func setupButtonConstraints() {
        NSLayoutConstraint.activate([
            btnRetry.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btnRetry.topAnchor.constraint(equalTo: noDataFoundLbl.bottomAnchor),
            btnRetry.widthAnchor.constraint(equalToConstant: 200),
            btnRetry.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func btnRetryTapped() {
        self.fetchNews(isRefresh: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: StoryCell.self), bundle: nil), forCellReuseIdentifier: StoryCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator =  false
        self.tableView.backgroundView = activityIndicator
        self.activityIndicator.center = self.tableView.backgroundView!.center
        activityIndicator.hidesWhenStopped = true
    }
    
    func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

//MARK : Managing UI hierarchy, contraints, configurantion
extension TopStoriesListVC: ViewCodeConfiguration {
    func buildHierarchy() {
        view.addSubview(tableView)
        view.addSubview(noDataFoundLbl)
        view.addSubview(btnRetry)
    }
    
    func setupContraints() {
        setupTableViewConstraints()
        setupButtonConstraints()
        setupLabelConstraints()
    }
    
    func configureViews() {
        hideNavigationItem = true
        setupTableView()
        setupLabel()
        setupButton()
    }
}

//#MARK: Table view delegate and data source methods
extension TopStoriesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.response?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryCell.reuseIdentifier, for: indexPath) as! StoryCell
        let item = self.viewModel?.response?.newsAtIndex(indexPath.row)
        cell.configureCell(newsItem: item!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = self.viewModel?.response?.newsAtIndex(indexPath.row) else { return  }
        self.pushDetailPage(item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var menuBar = CategoryMenuBar()
        menuBar = self.menuBar
        menuBar.delegate = self
        return menuBar
    }
}

//#MARK: MenuBar delegate
extension TopStoriesListVC: MenuBarDelegate {
    func newsSectionSelected(section: NYTTopStoriesEndpoint) {
        self.selectedSection = section
        self.fetchNews()
    }
}

extension TopStoriesListVC: StoryboardInstantiable {
    static var storyboardName: String { return "Main" }
    static var storyboardIdentifier: String? { return "TopStoriesListVC" }
}
