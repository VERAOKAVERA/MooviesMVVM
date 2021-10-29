// MooviesTests.swift
// Copyright © RoadMap. All rights reserved.

//
//  MooviesTests.swift
//  MooviesTests
//
//  Created by Vera Zaitseva on 14.10.2021.
//
@testable import Moovies
import UIKit
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class CoordinatorTests: XCTestCase {
    var appCoordinator: AppCoordinator!
    var navigationController: MockNavigationController!
    var builder: AssemblyProtocol!

    override func setUpWithError() throws {
        navigationController = MockNavigationController()
        builder = ModulesBuilder()
        appCoordinator = AppCoordinator(assemblyModule: builder, navController: navigationController)
    }

    override func tearDownWithError() throws {
        navigationController = nil
        builder = nil
        appCoordinator = nil
    }

    func testPresentedMovieVC() {
        appCoordinator.start()
        let movieVC = navigationController.presentedVC
        XCTAssertTrue(movieVC is MooviesViewController)
    }

    func testPresentedDetailsVC() {
        appCoordinator.start()
        guard let movieVC = navigationController.presentedVC as? MooviesViewController else { return }
        movieVC.showDetails?(Int())
        let detailsVC = navigationController.presentedVC
        XCTAssertTrue(detailsVC is MoovieDescriptionTableViewController)
    }
}
