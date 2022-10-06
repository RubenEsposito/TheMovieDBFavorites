//
//  FavoritesPresenter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol FavoritesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func numberOfItems() -> Int
    func movie(_ index: Int) -> ListResult?
    func didSelectRowAt(index: Int)
    func searchMovie(searchText: String)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    unowned var view: FavoritesViewControllerProtocol?
    let router: FavoritesRouterProtocol!
    let interactor: FavoritesInteractorProtocol!
    
    private var movies: [ListResult] = []
    
    init(
        view: FavoritesViewControllerProtocol,
        router: FavoritesRouterProtocol,
        interactor: FavoritesInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setupTableView()
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

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    
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
