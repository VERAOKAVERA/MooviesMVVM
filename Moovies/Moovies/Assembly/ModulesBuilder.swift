// ModulesBuilder.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

protocol AssemblyProtocol: AnyObject {
    func buildMain() -> UIViewController
    func buildDetails(movieID: Int?) -> UITableViewController
}

final class ModulesBuilder: AssemblyProtocol {
    func buildMain() -> UIViewController {
        let movieAPIService = MovieAPIService()
        let movieViewModel = MainViewModel(movieAPIService: movieAPIService)
        let movieViewController = MooviesViewController()
        movieViewController.setupViewModel(viewModel: movieViewModel)
        return movieViewController
    }

    func buildDetails(movieID: Int?) -> UITableViewController {
        let detailsTableViewController = MoovieDescriptionTableViewController()
        let movieAPIService = MovieAPIService()
        let detailsViewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: movieID)
        detailsTableViewController.setupViewModel(viewModel: detailsViewModel)
        return detailsTableViewController
    }
}
