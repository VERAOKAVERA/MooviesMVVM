// BaseCoordinator.swift
// Copyright © Vera Malygina. All rights reserved.

import Foundation
import UIKit

/// координатор
class BaseCoordinator {
    private var childCoordinators: [BaseCoordinator] = []

    required init(assemblyModule: AssemblyProtocol, navController: UINavigationController? = nil) {}

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }

        keyWindow?.rootViewController = controller
    }
}
