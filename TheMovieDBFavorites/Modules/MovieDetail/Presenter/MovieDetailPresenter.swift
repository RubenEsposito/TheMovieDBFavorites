//
//  MovieDetailPresenter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadInputViews()
    func addFavoritesButtonTapped(movieID: Int)
}

extension MovieDetailPresenter {
    fileprivate enum Constans {
        static let addFavorites: String = "Add to favorites"
        static let removeFavorites: String = "Remove from favorites"
    }
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    unowned var view: MovieDetailViewControllerProtocol?
    let router: MovieDetailRouterProtocol!
    let interactor: MovieDetailInteractorProtocol!
    
    private var movieDetail: MovieDetailResponse?
    
    init(
        view: MovieDetailViewControllerProtocol,
        router: MovieDetailRouterProtocol,
        interactor: MovieDetailInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        view?.setUpView()
        if let movieId = view?.getMovieId() {
            fetchMovieDetail(with: movieId)
        }
    }
    
    func loadInputViews() {
        
        let baseUrl = "https://image.tmdb.org/t/p/original/"
        if  let image = movieDetail?.backdrop_path,
            let url = URL(string: baseUrl + image) {
            view?.setMoviePoster(url)
        }
        
        if let title = movieDetail?.title {
            view?.setMovieTitle(title)
        }
        
        if let overview = movieDetail?.overview {
            view?.setMovieDescription(overview)
        }
        
        if let isFavorite = movieDetail?.favoriteStatus {
            let buttonText = isFavorite ? Constans.removeFavorites : Constans.addFavorites
            view?.setFavoritesButton(buttonText, isAdded: isFavorite)
        }
    }
    
    func addFavoritesButtonTapped(movieID: Int) {
        if let isFavorite = movieDetail?.favoriteStatus {
            if !isFavorite {
                if let movieDetail {
                    interactor.saveFavorite(movieDetail.favoriteRepresentation())
                }
            } else {
                interactor.removeFavorite(movieID)
            }
        }
        
        movieDetail?.favoriteStatus.toggle()
        
        if let isFavorite = movieDetail?.favoriteStatus {
            let buttonText = isFavorite ? Constans.removeFavorites : Constans.addFavorites
            view?.setFavoritesButton(buttonText, isAdded: isFavorite)
        }
    }
    
    private func fetchMovieDetail(with movieId: Int) {
        view?.showLoadingView()
        interactor.fetchMovieDetail(movieId)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    
    func fetchMovieDetail(result: MovieDetailResult) {
        view?.hideLoadingView()
        
        switch result {
        case .success(let movieDetail):
            self.movieDetail = movieDetail
            
            if let movieId = movieDetail.id {
                if interactor.isFavorite(movieId) {
                    self.movieDetail?.favoriteStatus = true
                }
            }
            
            view?.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
}
