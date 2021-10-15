// AppCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class AppCoordinator: BaseCoordinator {
    private var assemblyModule: AssemblyProtocol
    private var navController: UINavigationController?

    required init(assemblyModule: AssemblyProtocol, navController: UINavigationController? = nil) {
        self.assemblyModule = assemblyModule
        self.navController = navController
        super.init(assemblyModule: assemblyModule, navController: navController)
    }

    override func start() {
        toMovie()
    }

    private func toMovie() {
        let movieCoordinator = MainCoordinator(assemblyModule: assemblyModule, navController: navController)

        movieCoordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(movieCoordinator)
            self?.start()
        }

        addDependency(movieCoordinator)
        movieCoordinator.start()
    }
}
