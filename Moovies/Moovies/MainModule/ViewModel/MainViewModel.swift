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

protocol MainViewModelProtocol {
    var results: [MovieData.Result]? { get }
    var movieData: MovieHandler? { get }
    var reloadTable: VoidHandler? { get set }
    func getMovie(type: MovieListType)
}

// MARK: - Class MainViewModel

final class MainViewModel: MainViewModelProtocol {
    // MARK: - Internal Properties

    var results: [MovieData.Result]?
    var reloadTable: VoidHandler?
    var movieData: MovieHandler?

    // MARK: - InternalMethods

    func getMovie(type: MovieListType) {
        results?.removeAll()
        let url =
            "https://api.themoviedb.org/3/movie/\(type)?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        guard let url = URL(string: url) else { return }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pageMovies = try decoder.decode(MovieData.Film.self, from: usageData)
                self.results = pageMovies.results
                DispatchQueue.main.async {
                    self.reloadTable?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

    func setupSwitchSegmentControl() {}
}
