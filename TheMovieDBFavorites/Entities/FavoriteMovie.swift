//
//  FavoriteMovie.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

struct FavoriteMovieResult: Codable {
    let movies: [FavoriteMovie]
}

struct FavoriteMovie: Codable {
    let backdrop_path: String?
    let id: Int?
    let overview: String?
    let release_date: String?
    let title: String?
}
