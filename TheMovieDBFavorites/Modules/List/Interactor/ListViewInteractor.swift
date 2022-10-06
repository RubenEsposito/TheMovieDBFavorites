//
//  ListViewInteractor.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol ListInteractorProtocol: AnyObject {
    func fetchPopularMovies()
}

protocol ListInteractorOutputProtocol: AnyObject {
    func fetchPopularMovies(result: MovieListResult)
}

typealias MovieListResult = Result<ListResponse, Error>
fileprivate var movieService: MovieServiceProtocol = MovieService()

final class ListInteractor {
    var output: ListInteractorOutputProtocol?
}

extension ListInteractor: ListInteractorProtocol {
    
    func fetchPopularMovies() {
        movieService.fetchListPopularMovies { [weak self] result in
            guard let self = self else { return }
            self.output?.fetchPopularMovies(result: result)
        }
    }
}
