// MainCoordinator.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator {
   private var navController: UINavigationController?
   var onFinishFlow: VoidHandler?
    private  var assemblyModule: AssemblyProtocol

    required init(assemblyModule: AssemblyProtocol, navController: UINavigationController? = nil) {
        self.assemblyModule = assemblyModule
        self.navController = navController
        super.init(assemblyModule: assemblyModule, navController: navController)
    }

    override func start() {
        showMovieModule()
    }

    private func showMovieModule() {
        guard let movieVC = assemblyModule.buildMain() as? MooviesViewController else { return }

        movieVC.showDetails = { [weak self] movieID in
            self?.showDetailsModule(movieID: movieID)
        }

        if navController == nil {
            let navController = UINavigationController(rootViewController: movieVC)
            self.navController = navController
            setAsRoot(navController)
        } else if let navController = navController {
            navController.pushViewController(movieVC, animated: true)
            setAsRoot(navController)
        }
    }

    private func showDetailsModule(movieID: Int) {
        let detailVC = assemblyModule.buildDetails(movieID: movieID)
        navController?.pushViewController(detailVC, animated: true)
    }
}
