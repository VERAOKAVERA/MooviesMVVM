// MainViewModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import UIKit

/// Enum MoviesType
enum MovieListType: Int {
    case topRated
    case popular
    case upcoming

    var urlPath: String {
        switch self {
        case .popular:
            return "popular"
        case .topRated:
            return "top_rated"
        case .upcoming:
            return "upcoming"
        }
    }
}

// MARK: - Protocol MainViewModelProtocol

protocol MainViewModelProtocol: AnyObject {
    var results: [MovieData.Result]? { get }
    var movieData: MovieHandler? { get }
    var reloadTable: VoidHandler? { get set }
    func getMovie(type: MovieListType)
    func setupSwitchSegmentControl(segmentControl: UISegmentedControl)
}

// MARK: - Class MainViewModel

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol

    // MARK: - Internal Properties

    var results: [MovieData.Result]?
    var reloadTable: VoidHandler?
    var movieData: MovieHandler?

    // MARK: - Initialization

    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    // MARK: - Internal Methods

    func getMovie(type: MovieListType) {
        results?.removeAll()
        movieAPIService.getMovie(type: type) { [weak self] result in
            switch result {
            case let .success(result):
                self?.results = result
                DispatchQueue.main.async {
                    self?.reloadTable?()
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    func setupSwitchSegmentControl(segmentControl: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            getMovie(type: .popular)
        case 1:
            getMovie(type: .topRated)
        case 2:
            getMovie(type: .upcoming)
        default:
            getMovie(type: .popular)
        }
    }
}
