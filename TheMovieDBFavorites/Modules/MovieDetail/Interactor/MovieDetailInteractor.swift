//
//  MovieDetailInteractor.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchMovieDetail(_ movieId: Int)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func fetchMovieDetail(result: MovieDetailResult)
}

typealias MovieDetailResult = Result<MovieDetailResponse, Error>

fileprivate var movieService: MovieServiceProtocol = MovieService()

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
}
