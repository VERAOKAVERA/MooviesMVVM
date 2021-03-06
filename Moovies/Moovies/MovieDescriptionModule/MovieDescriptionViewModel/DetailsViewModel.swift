// DetailsViewModel.swift
// Copyright © Vera Malygina. All rights reserved.

import Foundation

protocol DetailsViewModelProtocol: AnyObject {
    var details: Description? { get }
    var reloadTable: VoidHandler? { get set }
    func getDetailsMovie()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    // MARK: - Internal Properties

    var movieID: Int?
    var reloadTable: VoidHandler?
    var details: Description?

    // MARK: - Private Properties

    private var movieAPIService: MovieAPIServiceProtocol
    private var repository: RealmRepository<Description>

    // MARK: - Initializers

    init(movieAPIService: MovieAPIServiceProtocol, movieID: Int?, repository: RealmRepository<Description>) {
        self.movieAPIService = movieAPIService
        self.movieID = movieID
        self.repository = repository
    }

    // MARK: - Internal Methods

    func getDetailsMovie() {
        if let cacheResults = repository.getDescription(of: movieID ?? 0) {
            details = cacheResults.first
        } else {
            movieAPIService.getMovieDetails(movieID: movieID ?? 0) { [weak self] result in
                switch result {
                case let .success(details):
                    self?.details = details
                    DispatchQueue.main.async {
                        self?.repository.save(object: [details])
                        self?.details = details
                        self?.reloadTable?()
                    }
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
