//
//  MovieFavoriteCell.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import UIKit
import SDWebImage

protocol MovieFavoritesCellProtocol: AnyObject {
    func setMovieImage(_ imageUrl: URL)
    func setTitleYearLabel(_ text: String)
    func setMovieDescriptionLabel(_ text: String)
    func setAccessibilityIdentifiers()
}

final class MovieFavoritesCell: UITableViewCell {
    
    @IBOutlet private weak var movieImage: UIImageView! {
        didSet {
            movieImage.layer.cornerRadius = 6
        }
    }
    @IBOutlet private weak var titleYearLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    
    
    var cellPresenter: MovieFavoritesCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension MovieFavoritesCell: MovieFavoritesCellProtocol {
    
    func setMovieImage(_ imageUrl: URL) {
        movieImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setTitleYearLabel(_ text: String) {
        titleYearLabel.text = text
    }
    
    func setMovieDescriptionLabel(_ text: String) {
        movieDescriptionLabel.text = text
    }
}

extension MovieFavoritesCell {
    func setAccessibilityIdentifiers() {
        movieImage.accessibilityIdentifier = "FavoritesCellMovieImage"
        titleYearLabel.accessibilityIdentifier = "FavoritesCellTitleYearLabel"
        movieDescriptionLabel.accessibilityIdentifier = "FavoritesCellMovieDescriptionLabel"
    }
}
