//
//  SearchCellPresenter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol SearchCellPresenterProtocol: AnyObject {
    func load()
}

final class SearchCellPresenter {
    
    weak var view: SearchCellProtocol?
    private let movie: SearchOutput
    
    init(view: SearchCellProtocol?, movie: SearchOutput) {
        self.view = view
        self.movie = movie
    }
}

extension SearchCellPresenter: SearchCellPresenterProtocol {
    
    func load() {
        if let title = movie.title,
           let year = movie.release_date?.prefix(4) {
            let yearText = year == "" ? "" : " (" + year + ")"
            view?.setTitleLabel(title + yearText)
        }
        view?.setAccessibilityIdentifiers()
    }
    
}
