//
//  TabBarRouter.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import Foundation
import UIKit

final class TabBarRouter {
    
    weak var viewController: UIViewController?
    
    typealias Submodules = (
        popular: UIViewController,
        favorites: UIViewController
    )
    
    static func createModule(usingSubmodules submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let tabBarController = TabBarViewController(tabs: tabs)
        return tabBarController
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
