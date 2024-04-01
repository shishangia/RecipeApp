//
//  SceneDelegate.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let tabBarController = UITabBarController()
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem = UITabBarItem(title: "Home",
                                                     image: UIImage(systemName: "house"), selectedImage: nil)

        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem = UITabBarItem(title: "Search",
                                                       image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)

        tabBarController.viewControllers = [homeViewController, searchViewController]

        window.rootViewController = tabBarController
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

