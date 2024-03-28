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
        window.rootViewController = UINavigationController(rootViewController: BaseViewController())
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}

