// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift
// ассоциативные данные
// enum MovieData {
//    // результаты топ-100 фильмов
//    case topRated([Result])
//    // результаты самых популярных фильмов
//    case popular([Result])
//    // результаты фильмов, которые скоро выйдут в прокат
//    case upcoming([Result])
//
struct Film: Decodable {
    var results: [Result]
}

/// результаты
class Result: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var overview = String()
    @objc dynamic var title = String()
    @objc dynamic var releaseDate = String()
    @objc dynamic var id = Int()
    @objc dynamic var voteAverage = Float()
    @objc dynamic var movieType = Int()
}

// }
