//
//  FavoritesViewInteractor.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject {
    func fetchPopularMovies()
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func fetchPopularMovies(result: MovieListResult)
}

fileprivate var movieService: MovieServiceProtocol = MovieService()

final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    
    func fetchPopularMovies() {
        movieService.fetchListPopularMovies { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchPopularMovies(result: result)
        }
    }
}
