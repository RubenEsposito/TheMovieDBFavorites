//
//  ServiceManager.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchListPopularMovies(completionHandler: @escaping (MovieListResult) -> ())
    func fetchSearch(query: String, completionHandler: @escaping (SearchedMovieResult) -> ())
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetailResult) -> ())
}

struct MovieService: MovieServiceProtocol {
    
    func fetchListPopularMovies(completionHandler: @escaping (MovieListResult) -> ()) {
        NetworkManager.shared.request(Router.listPopularMovies, decodeToType: ListResponse.self, completionHandler: completionHandler)
    }
    
    func fetchSearch(query: String, completionHandler: @escaping (SearchedMovieResult) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: SearchResponse.self, completionHandler: completionHandler)
    }
    
    func fetchMovieDetail(movieID: Int, completionHandler: @escaping (MovieDetailResult) -> ()) {
        NetworkManager.shared.request(Router.movieDetail(movieID: movieID), decodeToType: MovieDetailResponse.self, completionHandler: completionHandler)
    }
}
