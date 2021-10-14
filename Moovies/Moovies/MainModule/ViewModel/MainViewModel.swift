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
    var results: [Result]? { get }
    var movieData: MovieHandler? { get }
    var reloadTable: VoidHandler? { get set }
    func getMovie(type: MovieListType)
    func setupSwitchSegmentControl(segmentControl: UISegmentedControl)
}

// MARK: - Class MainViewModel

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: DataBaseRepository<Result>

    // MARK: - Internal Properties

    var results: [Result]?
    var reloadTable: VoidHandler?
    var movieData: MovieHandler?

    // MARK: - Initialization

    init(movieAPIService: MovieAPIServiceProtocol, repository: DataBaseRepository<Result>) {
        self.movieAPIService = movieAPIService
        self.repository = repository
    }

    // MARK: - Internal Methods

    func getMovie(type: MovieListType) {
        results?.removeAll()

        let predicate = NSPredicate(format: "movieType == %@", String(type.urlPath))
        results = repository.get(predicate: predicate)

        if results == nil {
            movieAPIService.getMovie(type: type) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(result):

                    DispatchQueue.main.async {
                        self.repository.save(object: result)
                        self.results = self.repository.get(predicate: predicate)
                        self.reloadTable?()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } else {
            results = repository.get(predicate: predicate)
            DispatchQueue.main.async {
                self.reloadTable?()
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
