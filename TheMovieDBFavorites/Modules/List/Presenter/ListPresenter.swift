//
//  ListPresenter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol ListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> ListResult?
    func didSelectRowAt(index: Int)
    func searchMovie(searchText: String)
}

final class ListPresenter: ListPresenterProtocol {
    
    unowned var view: ListViewControllerProtocol?
    let router: ListRouterProtocol!
    let interactor: ListInteractorProtocol!
    
    private var movies: [ListResult] = []
    
    init(
        view: ListViewControllerProtocol,
        router: ListRouterProtocol,
        interactor: ListInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
        view?.setupSearchView()
        fetchMovies()
    }
    
    func viewWillAppear() {
        view?.setUpView()
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func movie(_ index: Int) -> ListResult? {
        return movies[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else { return }
        router.navigate(.detail(movieId: movie.id))
    }
    
    func searchMovie(searchText: String) {
        router.navigate(.search(text: searchText))
    }
    
    private func fetchMovies() {
        view?.showLoadingView()
        interactor.fetchPopularMovies()
    }
}

extension ListPresenter: ListInteractorOutputProtocol {
    
    func fetchPopularMovies(result: MovieListResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let moviesResult):
            if let movies = moviesResult.results {
                self.movies = movies
                view?.reloadData()
            }
        case .failure(let error):
            print(error)
        }
    }
}
