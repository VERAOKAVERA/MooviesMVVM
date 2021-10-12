// ModulesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol AssemblyProtocol: AnyObject {
    func buildMain(viewModel: MainViewModelProtocol) -> UINavigationController
}

final class ModulesBuilder: AssemblyProtocol {
    func buildMain(viewModel _: MainViewModelProtocol) -> UINavigationController {
        let mainViewController = MooviesViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        return navigationController
    }
}
