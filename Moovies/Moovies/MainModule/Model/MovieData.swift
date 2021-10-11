//
//  ViewData.swift
//  Moovies
//
//  Created by Vera Zaitseva on 11.10.2021.
//

import Foundation
// ассоциативные данные
enum MovieData {
    case topRated([Result])
    case popular([Result])
    case upcoming([Result])

    struct Film: Decodable {
        var results: [Result]
    }

    struct Result: Decodable {
        let posterPath: String
        let overview: String
        let title: String
        let releaseDate: String?
        let id: Int?
        let voteAverage: Float?
    }
}
