//
//  MainViewModel.swift
//  Moovies
//
//  Created by Vera Zaitseva on 11.10.2021.
//

import Foundation

    // MARK: - Protocol MainViewModelProtocol
protocol MainViewModelProtocol {
    var results: [MovieData.Result]? { get }
    var movieData: UpdateMovieHandler? { get }
    var reloadTable: VoidHandler? { get set }
    func getMovie(url: String)
}

    // MARK: - Class MainViewModel
final class MainViewModel: MainViewModelProtocol {
    public var results: [MovieData.Result]?
    public var reloadTable: VoidHandler?
    public var movieData: UpdateMovieHandler?

    // MARK: - InternalMethods
    func getMovie(url: String) {
        results?.removeAll()
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
}
