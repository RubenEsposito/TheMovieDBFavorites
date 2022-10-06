//
//  LocalStorageManager.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

let favoriteMoviesKey = "favoriteMoviesKey"

protocol LocalStorageManagerProtocol {
    func saveFavoriteMovie(movie: FavoriteMovie)
    func getMovie(withId movieId: Int) -> FavoriteMovie?
    func removeMovie(withId movieId: Int)
    func getFavoriteMovies() -> [FavoriteMovie]
}

final class LocalStorageManager: LocalStorageManagerProtocol {
    
    static let shared: LocalStorageManager = {
        let instance = LocalStorageManager()
        return instance
    }()
    
    func saveFavoriteMovie(movie: FavoriteMovie) {
        var movies = getSavedFavoriteMovies()
        movies.append(movie)
        updateFavoriteMovies(newMovies: movies)
    }
    
    func getMovie(withId movieId: Int) -> FavoriteMovie? {
        let movies = getSavedFavoriteMovies()
        return movies.first(where: { $0.id == movieId })
    }
    
    func removeMovie(withId movieId: Int) {
        var movies = getSavedFavoriteMovies()
        movies.removeAll(where: { $0.id == movieId })
        updateFavoriteMovies(newMovies: movies)
    }
    
    func getFavoriteMovies() -> [FavoriteMovie] {
        return getSavedFavoriteMovies()
    }
    
    private func getSavedFavoriteMovies() -> [FavoriteMovie] {
        let defaults = UserDefaults.standard
        if let savedMovies = defaults.object(forKey: favoriteMoviesKey) as? Data {
            let decoder = JSONDecoder()
            if let loadedMovies = try? decoder.decode([FavoriteMovie].self, from: savedMovies) {
                return loadedMovies
            }
        }
        return []
    }
    
    private func updateFavoriteMovies(newMovies movies: [FavoriteMovie]) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: favoriteMoviesKey)
        if let encodedMovies = try? JSONEncoder().encode(movies) {
            defaults.set(encodedMovies, forKey: favoriteMoviesKey)
        }
    }
}
