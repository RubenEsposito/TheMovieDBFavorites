//
//  FavoritesRouter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation
import UIKit

protocol FavoritesRouterProtocol: AnyObject {
    func navigate(_ route: FavoritesRoutes)
}

enum FavoritesRoutes {
    case detail(movieId: Int?)
    case search(text: String?)
}

final class FavoritesRouter {
    
    weak var viewController: FavoritesViewController?
    
    static func createModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension FavoritesRouter: FavoritesRouterProtocol {
    
    func navigate(_ route: FavoritesRoutes) {
        switch route {
            
        case .detail(let movieId):
            let detailVC = MovieDetailRouter.createModule()
            detailVC.movieId = movieId
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
            
        case .search(let text):
            guard let text = text,
                  text.count > 2 else { return }
            let searchVC = SearchRouter.createModule()
            searchVC.searchText = text
            
            if let topVC = viewController?.navigationController?.topViewController {
                searchVC.view.frame = topVC.view.bounds
                
                if topVC.children.count > 0 {
                    let viewControllers: [UIViewController] = topVC.children
                    viewControllers.last?.removeFromParent()
                    viewControllers.last?.view.removeFromSuperview()
                }
                viewController?.navigationController?.topViewController?.addChild(searchVC)
                viewController?.navigationController?.topViewController?.view.addSubview(searchVC.view)
            }
        }
    }
}
