//
//  SceneDelegate.swift
//  Moovies
//
//  Created by Vera Zaitseva on 17.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let mainViewController = MooviesViewController()
        let mainViewModel = MainViewModel()
        mainViewController.setupViewModel(viewModel: mainViewModel)
        let navController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()

//        let navigationController = UINavigationController(rootViewController: vc)
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {}

    func sceneWillResignActive(_: UIScene) {}

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}
}
