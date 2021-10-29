// MovieAPIServiceTests.swift
// Copyright © Vera Malygina. All rights reserved.

import Foundation
@testable import Moovies
import UIKit
import XCTest

///
class MockAPIService: MovieAPIServiceProtocol {
    func getMovie(type: MovieListType, completion: @escaping (Result<[Results], Error>) -> ()) {
        let movieOne = Results()
        movieOne.id = 13578
        movieOne.posterPath = ""
        movieOne.overview = ""
        movieOne.title = "Test film1"
        movieOne.releaseDate = ""
        movieOne.voteAverage = 2.0
        movieOne.movieType = "popular"

        let movieTwo = Results()
        movieTwo.id = 13578
        movieTwo.posterPath = ""
        movieTwo.overview = ""
        movieTwo.title = "Test film2"
        movieTwo.releaseDate = ""
        movieTwo.voteAverage = 2.0
        movieTwo.movieType = "top_rated"

        let movieThree = Results()
        movieThree.id = 13578
        movieThree.posterPath = ""
        movieThree.overview = ""
        movieThree.title = "Test film3"
        movieThree.releaseDate = ""
        movieThree.voteAverage = 2.0
        movieThree.movieType = "upcoming"

//        completion(.success([movieOne, movieTwo, movieThree]))

        switch type {
        case .popular: completion(.success([movieOne]))
        case .topRated: completion(.success([movieOne, movieTwo]))
        case .upcoming: completion(.success([movieOne, movieTwo, movieThree]))
        }
    }

    func getMovieDetails(movieID: Int, completion: @escaping (Result<Description, Error>) -> ()) {
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

///
class MockRepository: Repository<Results> {
    typealias Entity = Results

    var mockStorage: [MovieListType: [Entity]] = [:]

    override func getMoviesList(of type: MovieListType) -> [Entity] {
        mockStorage[type] ?? []
    }

    override func save(object: [Entity]) {
        if let rawMovieType = object.first?.movieType, let movieType = MovieListType(rawValue: rawMovieType) {
            mockStorage[movieType] = object
        }
    }

    override func getDescription(of movieID: Int) -> [Entity]? {
        fatalError()
    }

    override func removeAll() {}
}

final class MovieAPIServiceTests: XCTestCase {
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testPopularRequestMovieAPIService() {
        let mockAPIService = MockAPIService()
        let repository = MockRepository()
        let mainViewModel = MainViewModel(movieAPIService: mockAPIService, repository: repository)
        mainViewModel.setSelectedPage(0)

        let expectation = self.expectation(description: "MovieAPIService")
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(100))) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(mainViewModel.results?.count, 1)

        mainViewModel.results?.removeAll()
        mainViewModel.setSelectedPage(0)
        XCTAssertEqual(mainViewModel.results?.count, 1)
    }

    func testTopRatedRequestMovieAPIService() {
        let mockAPIService = MockAPIService()
        let repository = MockRepository()
        let mainViewModel = MainViewModel(movieAPIService: mockAPIService, repository: repository)
        mainViewModel.setSelectedPage(1)

        let expectation = self.expectation(description: "MovieAPIService")
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(100))) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(mainViewModel.results?.count, 2)
    }

    func testUpcomingRequestMovieAPIService() {
        let mockAPIService = MockAPIService()
        let repository = MockRepository()
        let mainViewModel = MainViewModel(movieAPIService: mockAPIService, repository: repository)
        mainViewModel.setSelectedPage(2)

        let expectation = self.expectation(description: "MovieAPIService")
        DispatchQueue.main.asyncAfter(deadline: .now().advanced(by: .milliseconds(100))) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(mainViewModel.results?.count, 3)
    }
}
