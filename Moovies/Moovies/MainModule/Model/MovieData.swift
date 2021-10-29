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
struct Film: Codable {
    var results: [Results]
}

/// результаты
@objc final class Results: Object, Codable {
    @objc dynamic var posterPath = String()
    @objc dynamic var overview = String()
    @objc dynamic var title = String()
    @objc dynamic var releaseDate = String()
    @objc dynamic var id = Int()
    @objc dynamic var voteAverage = Float()
    @objc dynamic var movieType: String?

    override class func primaryKey() -> String? {
        "title"
    }
}
