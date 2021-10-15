// MovieAPIService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol MovieAPIServiceProtocol: AnyObject {
    func getMovie(type: MovieListType, completion: @escaping (Swift.Result<[Results], Error>) -> ())
    func getMovieDetails(movieID: Int, completion: @escaping (Swift.Result<Description, Error>) -> ())
}

final class MovieAPIService: MovieAPIServiceProtocol {
    // MARK: - Internal Methods

    func getMovie(type: MovieListType, completion: @escaping (Swift.Result<[Results], Error>) -> ()) {
        let urlAPI =
            "https://api.themoviedb.org/3/movie/\(type.urlPath)?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        guard let url = URL(string: urlAPI) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movieList = try decoder.decode(Film.self, from: usageData)
                completion(.success(movieList.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getMovieDetails(movieID: Int, completion: @escaping (Swift.Result<Description, Error>) -> ()) {
        guard let urlAPI =
            URL(
                string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
            ) else { return }

        URLSession.shared.dataTask(with: urlAPI) { data, _, _ in
            guard let usageData = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let details = try decoder.decode(Description.self, from: usageData)
                completion(.success(details))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
