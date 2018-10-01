//
//  MainTabBarController.swift
//  Podacasts
//
//  Created by Rishabh Raj on 01/10/18.
//  Copyright © 2018 Rishabh Raj. All rights reserved.
//

import UIKit

class MainTabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .purple 
        UINavigationBar.appearance().prefersLargeTitles = true
        setupViewControllers()
    }
    
    // MARK:- Setup Functions
    
    func setupViewControllers() {
        viewControllers = [
            generateNavController(for: FavouritesController(), title: "Search", image: UIImage(named: "search")!),
            generateNavController(for: FavouritesController(), title: "Favourites", image: UIImage(named: "favourites")!),
            generateNavController(for: FavouritesController(), title: "Downloads", image: UIImage(named: "downloads")!)
        ]
 
    }
    
    // MARK:- Helper Functions
    
    fileprivate func generateNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
