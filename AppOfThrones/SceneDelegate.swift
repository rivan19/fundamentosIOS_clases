//
//  SceneDelegate.swift
//  AppOfThrones
//
//  Created by Ivan Llopis Guardado on 11/02/2020.
//  Copyright © 2020 Ivan Llopis Guardado. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let episodeViewController = EpisodeViewController()
        let castViewController = CastViewController()
        let houseViewController = HouseViewController()
        let settingsViewController = SettingsViewController()
        let favoriteViewController = FavoriteViewController()
        
        
        episodeViewController.tabBarItem = UITabBarItem.init(title: "Seasons", image: UIImage.init(systemName: "film.fill"), tag: 0)
        castViewController.tabBarItem = UITabBarItem.init(title: "Cast", image: UIImage.init(systemName: "person.3.fill"), tag: 1)
        
        houseViewController.tabBarItem = UITabBarItem.init(title: "House", image: UIImage.init(systemName: "shield.lefthalf.fill"), tag: 2)
        
        favoriteViewController.tabBarItem = UITabBarItem.init(title: "Favorites", image: UIImage.init(systemName: "heart"), tag: 3)
        favoriteViewController.tabBarItem.selectedImage = UIImage.init(systemName: "heart.fill")
        
        favoriteViewController.title = "Favorites"
        
        settingsViewController.tabBarItem = UITabBarItem.init(title: "Settings", image: UIImage.init(systemName: "gear"), tag: 4)
        
        
        let navigationEpisodeViewController = UINavigationController.init(rootViewController: episodeViewController)
        let navigationCastViewController = UINavigationController.init(rootViewController: castViewController)
        let navigationHouseViewController = UINavigationController.init(rootViewController: houseViewController)
        let navigationFavoritesViewController = UINavigationController.init(rootViewController: favoriteViewController)
        let navigationSettingsViewController = UINavigationController.init(rootViewController: settingsViewController)
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [navigationEpisodeViewController, navigationCastViewController, navigationHouseViewController, navigationFavoritesViewController, navigationSettingsViewController]
        
        tabBarController.tabBar.barStyle = .black
        tabBarController.tabBar.tintColor = UIColor.init(red: 235/255.0, green: 172/255.0, blue: 38/255.0, alpha: 1.0)
        
        UINavigationBar.appearance().overrideUserInterfaceStyle = .dark
        UINavigationBar.appearance().tintColor = UIColor.init(red: 235/255.0, green: 172/255.0, blue: 38/255.0, alpha: 1.0)
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

