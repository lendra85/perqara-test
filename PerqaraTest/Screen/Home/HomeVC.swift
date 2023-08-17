//
//  HomeVC.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 15/08/23.
//

import UIKit

class HomeVC: UIViewController {
    private lazy var topView = UIView().with(parent: view)
    private lazy var searchView = UISearchBar().with(parent: view)
    private lazy var tableView = UITableView().with(parent: view)
    private var viewModel: HomeVM!
    private var isFinishLoad = false
    private var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVM()
        setupTopView()
        setupSearchView()
        setupTableView()
        setupObserver()
    }
    
    private func setupObserver() {
        viewModel.gamesResponse = { [weak self] games in
            self?.bindDataToView(games)
        }
    }
    
    private func setupTopView() {
        topView.backgroundColor = .systemIndigo
        topView.makeConstraint {
            $0.topAnchor == view.topAnchor
            $0.leadingAnchor == view.leadingAnchor
            $0.trailingAnchor == view.trailingAnchor
        }
        let titleLabel = UILabel().with(parent: topView)
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.text = "Games For You"
        titleLabel.makeConstraint {
            $0.leadingAnchor == topView.leadingAnchor + .x12
            $0.topAnchor == view.safeAreaLayoutGuide.topAnchor + .x12
            $0.bottomAnchor == topView.bottomAnchor - .x16
        }
    }
    
    private func setupSearchView() {
        searchView.delegate = self
        searchView.placeholder = "Search"
        searchView.backgroundImage = UIImage()
        searchView.makeConstraint {
            $0.topAnchor == topView.bottomAnchor + .x8
            $0.leadingAnchor == view.leadingAnchor + .x16
            $0.trailingAnchor == view.trailingAnchor - .x16
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellWithClass: GameCell.self)
        tableView.register(cellWithClass: LoadingCell.self)
        tableView.separatorStyle = .none
        tableView.makeConstraint {
            $0.topAnchor == searchView.bottomAnchor + .x12
            $0.leadingAnchor == view.leadingAnchor
            $0.trailingAnchor == view.trailingAnchor
            $0.bottomAnchor == view.bottomAnchor
        }
    }
    
    private func bindDataToView(_ games: [Game]) {
        let lastCount: Int = (viewModel?.games.count).ifNil(0)
        var indexPaths: [IndexPath] = []
        viewModel?.games.append(contentsOf: games)
        for i in lastCount..<(viewModel?.games.count).ifNil(0) {
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        tableView.insertRows(at: indexPaths, with: .bottom)
        isFinishLoad = games.isEmpty
        if isFinishLoad {
            tableView.reloadSections([1], with: .none)
        } else {
            viewModel?.page = (viewModel?.page).ifNil(1) + 1
        }
        isLoading = false
    }
}

extension HomeVC: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        viewModel?.page = 1
        viewModel?.games.removeAll()
        isFinishLoad = false
        isLoading = false
        tableView.reloadData()
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchKeyword = searchText
        if searchText.isEmpty {
            searchBarSearchButtonClicked(searchBar)
        } else {
            searchBar.showsCancelButton = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchBar.text = nil
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (viewModel?.games.count).ifNil(0)
        } else {
            return isFinishLoad ? 0 : 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withClass: GameCell.self, for: indexPath)
            cell.game = viewModel?.games[safe: indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withClass: LoadingCell.self, for: indexPath)
            cell.loadingView.startAnimating()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is LoadingCell && !isLoading && !isFinishLoad {
            viewModel.fetchData()
            isLoading = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let gameId = viewModel?.games[safe: indexPath.row]?.id, indexPath.section == 0 else {
            return
        }
        
        let controller = GameDetailVC()
        controller.id = gameId
        navigationController?.pushViewController(controller, animated: true)
    }
}
