// MainViewModel.swift
// Copyright © Vera Malygina. All rights reserved.

import Foundation
import UIKit

/// Enum MoviesType
enum MovieListType: String {
    case topRated = "top_rated"
    case popular
    case upcoming

    var urlPath: String {
        rawValue
    }
}

// MARK: - Protocol MainViewModelProtocol

protocol MainViewModelProtocol: AnyObject {
    var results: [Results]? { get }
    var movieData: MovieHandler? { get }
    var reloadTable: VoidHandler? { get set }
    func setSelectedPage(_ page: Int)
}

// MARK: - Class MainViewModel

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: Repository<Results>

    // MARK: - Internal Properties

    var results: [Results]?
    var reloadTable: VoidHandler?
    var movieData: MovieHandler?

    // MARK: - Initialization

    init(movieAPIService: MovieAPIServiceProtocol, repository: Repository<Results>) {
        self.movieAPIService = movieAPIService
        self.repository = repository
    }

    // MARK: - Internal Methods

    private func getMovie(type: MovieListType) {
        results?.removeAll()

        let cacheResults = repository.getMoviesList(of: type)

        if cacheResults.isEmpty {
            movieAPIService.getMovie(type: type) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(result):
                    DispatchQueue.main.async {
                        self.repository.save(object: result)
                        self.results = result
                        self.reloadTable?()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        } else {
            results = cacheResults
            DispatchQueue.main.async {
                self.reloadTable?()
            }
        }
    }

    func setSelectedPage(_ page: Int) {
        switch page {
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
