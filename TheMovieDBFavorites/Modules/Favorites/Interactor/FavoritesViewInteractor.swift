//
//  FavoritesViewInteractor.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject {
    func fetchFavoriteMovies()
}

protocol FavoritesInteractorOutputProtocol: AnyObject {
    func fetchFavoriteMovies(result: [FavoriteMovie])
}

fileprivate var localStorageManager: LocalStorageManagerProtocol = LocalStorageManager()
final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    
    func fetchFavoriteMovies() {
        let movies = localStorageManager.getFavoriteMovies()
        self.output?.fetchFavoriteMovies(result: movies)
    }
}
