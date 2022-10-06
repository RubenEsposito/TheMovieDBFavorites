//
//  TabBarRouter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import UIKit

class TabBarRouter {
    
    var viewController: UIViewController
    
    typealias Submodules = (
        popular: UIViewController,
        favorites: UIViewController
    )
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension TabBarRouter {
    
    static func tabs(usingSubmodules submodules: Submodules) -> Tabs {
        
        let popularTabBarItem = UITabBarItem(title: "Popular Movies", image: UIImage(systemName: "popcorn.circle.fill"), tag: 101)
        let favoriteTabBarItem = UITabBarItem(title: "Favorite Movies", image: UIImage(systemName: "star.circle.fill"), tag: 102)
        
        submodules.popular.tabBarItem = popularTabBarItem
        submodules.favorites.tabBarItem = favoriteTabBarItem
        
        return (
            popular: submodules.popular,
            favorites: submodules.favorites
        )
    }
}
