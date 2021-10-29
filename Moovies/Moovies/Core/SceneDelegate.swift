// SceneDelegate.swift
// Copyright © Vera Malygina. All rights reserved.

import UIKit

/// Scene Delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        (scene as? UIWindowScene) != nil
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        window.makeKeyAndVisible()
        self.window = window

        appCoordinator = AppCoordinator(assemblyModule: ModulesBuilder())
        appCoordinator?.start()
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {}

    func sceneWillResignActive(_: UIScene) {}

    func sceneWillEnterForeground(_: UIScene) {}

    func sceneDidEnterBackground(_: UIScene) {}
}
