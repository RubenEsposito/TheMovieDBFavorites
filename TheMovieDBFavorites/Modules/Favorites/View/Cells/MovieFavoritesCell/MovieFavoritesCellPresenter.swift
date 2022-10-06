//
//  MovieFavoriteCellPresenter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol MovieFavoritesCellPresenterProtocol: AnyObject {
    func load()
}

final class MovieFavoritesCellPresenter {
    
    weak var view: MovieFavoritesCellProtocol?
    private let movie: FavoriteMovie
    
    init(view: MovieFavoritesCellProtocol?, movie: FavoriteMovie) {
        self.view = view
        self.movie = movie
    }
}

extension MovieFavoritesCellPresenter: MovieFavoritesCellPresenterProtocol {
    
    func load() {
        let baseUrl = "https://image.tmdb.org/t/p/w500/"
        if  let image = movie.backdrop_path,
            let url = URL(string: baseUrl + image) {
            view?.setMovieImage(url)
        }
        
        if let title = movie.title,
           let year = movie.release_date?.prefix(4) {
            let yearText = year == "" ? "" : " (" + year + ")"
            view?.setTitleYearLabel(title + yearText)
        }
        
        if let overview = movie.overview {
            view?.setMovieDescriptionLabel(overview)
        }
        
        view?.setAccessibilityIdentifiers()
    }
}

