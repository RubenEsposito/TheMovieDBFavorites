//
//  TabBarModuleBuilder.swift
//  TheMovieDBFavorites
//
//  Created by Ruben Exposito Marin on 6/10/22.
//

import UIKit

class TabBarModuleBuilder {
    
    static func build(usingSubmodules submodules: TabBarRouter.Submodules) -> UITabBarController {
        let tabs = TabBarRouter.tabs(usingSubmodules: submodules)
        let tabBarController = TabBarViewController(tabs: tabs)
        return tabBarController
    }
}
