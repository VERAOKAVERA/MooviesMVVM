// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

struct Film: Codable {
    var results: [Result]
}

/// результаты
@objc final class Result: Object, Codable {
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
