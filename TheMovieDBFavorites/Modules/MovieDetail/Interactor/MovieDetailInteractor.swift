//
//  MovieDetailInteractor.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(_ movieId: Int)
    func saveFavorite(_ movie: FavoriteMovie)
    func removeFavorite(_ movieId: Int)
    func isFavorite(_ movieId: Int) -> Bool
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetail(result: MovieDetailResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse, Error>

fileprivate var movieService: MovieServiceProtocol = MovieService()
fileprivate var localStorageManager: LocalStorageManagerProtocol = LocalStorageManager()

final class MovieDetailInteractor {
    var output: MovieDetailInteractorOutputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
    
    func fetchMovieDetail(_ movieId: Int) {
        movieService.fetchMovieDetail(movieID: movieId) { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchMovieDetail(result: result)
        }
    }
    
    func saveFavorite(_ movie: FavoriteMovie) {
        localStorageManager.saveFavoriteMovie(movie: movie)
    }
    
    func removeFavorite(_ movieId: Int) {
        localStorageManager.removeMovie(withId: movieId)
    }
    
    func isFavorite(_ movieId: Int) -> Bool {
        return localStorageManager.getMovie(withId: movieId) != nil
    }
}
