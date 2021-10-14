// MoovieDescription.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

// необходимые данные для описания фильма
class Description: Object, Decodable {
    @objc dynamic var posterPath = String()
    @objc dynamic var title = String()
    @objc dynamic var overview = String()
}
