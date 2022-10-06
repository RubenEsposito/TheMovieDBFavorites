//
//  SearchCell.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import UIKit

protocol SearchCellProtocol: AnyObject {
    func setTitleLabel(_ text: String)
    func setAccessibilityIdentifiers()
}

final class SearchCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    var cellPresenter: SearchCellPresenterProtocol! {
        didSet {
            cellPresenter.load()
        }
    }
}

extension SearchCell: SearchCellProtocol {
    
    func setTitleLabel(_ text: String) {
        movieTitleLabel.text = text
    }

}

extension SearchCell {
    func setAccessibilityIdentifiers() {
        movieTitleLabel.accessibilityIdentifier = "movieTitleLabel"
    }
}
