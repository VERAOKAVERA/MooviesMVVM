//
//  ModulesBuilder.swift
//  Moovies
//
//  Created by Vera Zaitseva on 11.10.2021.
//

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
