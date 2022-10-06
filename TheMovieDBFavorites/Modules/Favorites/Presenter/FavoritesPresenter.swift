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
    func movie(_ index: Int) -> FavoriteMovie?
    func didSelectRowAt(index: Int)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {
    
    unowned var view: FavoritesViewControllerProtocol?
    let router: FavoritesRouterProtocol!
    let interactor: FavoritesInteractorProtocol!
    
    private var movies: [FavoriteMovie] = []
    
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
    }
    
    func viewWillAppear() {
        view?.setUpView()
        fetchMovies()
    }
    
    func numberOfItems() -> Int {
        return movies.count
    }
    
    func movie(_ index: Int) -> FavoriteMovie? {
        return movies[safe: index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let movie = movie(index) else { return }
        router.navigate(.detail(movieId: movie.id))
    }
    
    private func fetchMovies() {
        view?.showLoadingView()
        interactor.fetchFavoriteMovies()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    
    func fetchFavoriteMovies(result: [FavoriteMovie]) {
        view?.hideLoadingView()
        self.movies = result
        view?.reloadData()
    }
}
