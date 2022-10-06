//
//  MovieDetailViewController.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import UIKit
import SDWebImage

protocol MovieDetailViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setUpView()
    func setMoviePoster(_ imageUrl: URL)
    func setMovieTitle(_ text: String)
    func setMovieDescription(_ text: String)
    func setFavoritesButton(_ text: String, isAdded: Bool)
    func getMovieId() -> Int?
}

class MovieDetailViewController: UIViewController {
    
    @IBOutlet private weak var moviePosterImage: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var movieDescriptionTextView: UITextView!
    @IBOutlet private weak var addFavoritesButton: UIButton! {
        didSet {
            addFavoritesButton.layer.cornerRadius = 8
            addFavoritesButton.layer.borderWidth = 1
            addFavoritesButton.layer.borderColor = UIColor.lightGray.cgColor
            addFavoritesButton.backgroundColor = .systemYellow
            addFavoritesButton.tintColor = .black
        }
    }
    
    var movieId: Int?
    var presenter: MovieDetailPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func didTapAddFavorites(_ sender: Any) {
        presenter.addFavoritesButtonTapped(movieID: self.movieId ?? 0)
    }
    
}

// MARK: - MovieDetailViewControllerProtocol
extension MovieDetailViewController: MovieDetailViewControllerProtocol, LoadingShowable {
    
    func setMoviePoster(_ imageUrl: URL) {
        moviePosterImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder_movie_poster"))
    }
    
    func setMovieTitle(_ text: String) {
        movieTitleLabel.text = text
    }
    
    func setMovieDescription(_ text: String) {
        movieDescriptionTextView.text = text
    }
    
    func setFavoritesButton(_ text: String, isAdded: Bool) {
        addFavoritesButton.setTitle(text, for: .normal)
        addFavoritesButton.backgroundColor = isAdded ? .lightGray : .systemYellow
        addFavoritesButton.tintColor = isAdded ? .white : .black
    }
    
    func reloadData() {
        self.presenter.loadInputViews()
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setUpView() {
        setAccessibilityIdentifiers()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    func getMovieId() -> Int? {
        return movieId
    }
}

extension MovieDetailViewController {
    func setAccessibilityIdentifiers() {
        moviePosterImage.accessibilityIdentifier = "moviePosterImage"
        movieTitleLabel.accessibilityIdentifier = "movieTitleLabel"
        movieDescriptionTextView.accessibilityIdentifier = "movieDescriptionTextView"
        addFavoritesButton.accessibilityIdentifier = "addFavoritesButton"
    }
}
