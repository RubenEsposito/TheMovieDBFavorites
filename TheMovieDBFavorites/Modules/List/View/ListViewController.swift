//
//  ListViewController.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import UIKit

protocol ListViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupSearchView()
    func setupTableView()
    func setUpView()
}

final class ListViewController: BaseViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
        
    var presenter: ListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

// MARK: - ListViewControllerProtocol
extension ListViewController: ListViewControllerProtocol, LoadingShowable {
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupSearchView() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: MovieListCell.self)
    }
    
    func setUpView() {
        setAccessibilityIdentifiers()
        self.navigationController?.navigationBar.tintColor = .black
    }
}

extension ListViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let topVC = self.navigationController?.topViewController {
            
            if topVC.children.count > 0 {
                let viewControllers: [UIViewController] = topVC.children
                viewControllers.last?.removeFromParent()
                viewControllers.last?.view.removeFromSuperview()
            }
        }
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem.perform(after: 0.5) {
            
            self.presenter.searchMovie(searchText: searchText)
        }
    }
}

// MARK: - TableView (List)
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: MovieListCell.self, for: indexPath)
        cell.selectionStyle = .none
        if let movie = presenter.movie(indexPath.row) {
            cell.cellPresenter = MovieListCellPresenter(view: cell, movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
}

extension ListViewController {
    func setAccessibilityIdentifiers() {
        searchBar.accessibilityIdentifier = "listSearchBar"
        tableView.accessibilityIdentifier = "listTableView"
    }
}



