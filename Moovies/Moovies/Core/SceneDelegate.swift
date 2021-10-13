// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Scene Delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        (scene as? UIWindowScene) != nil
        let mainViewController = MooviesViewController()
        let movieAPIService = MovieAPIService()
        let mainViewModel = MainViewModel(movieAPIService: movieAPIService)
        mainViewController.setupViewModel(viewModel: mainViewModel)
        let navController = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {}

    func sceneWillResignActive(_: UIScene) {}

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}
}
