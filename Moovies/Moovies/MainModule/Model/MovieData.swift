// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
// ассоциативные данные
enum MovieData {
    // результаты топ-100 фильмов
    case topRated([Result])
    // результаты самых популярных фильмов
    case popular([Result])
    // результаты фильмов, которые скоро выйдут в прокат
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
