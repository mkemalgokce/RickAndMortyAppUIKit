//
//  MainTabViewController.swift
//  RickAndMortyApp
//
//  Created by Mustafa Kemal Gökçe on 2.04.2023.
//



import UIKit

class MainTabViewController: UITabBarController{

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myBackgroundColor
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let favVc = UINavigationController(rootViewController: FavouriteCardsViewController())
        let searchVC = UINavigationController(rootViewController: SearchCardsViewController())
        
        homeVC.tabBarItem.image = UIImage(systemName: "house")
        homeVC.navigationBar.barTintColor = myBackgroundColor
        favVc.tabBarItem.image = UIImage(systemName: "star")
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        homeVC.title = "Home"
        favVc.title = "Favourites"
        searchVC.title = "Search"
        
    
        tabBar.tintColor = textColor
        tabBar.barTintColor = myBackgroundColor
        
        print("Here")
        
        setViewControllers([homeVC, favVc, searchVC], animated: true)

    }


}

