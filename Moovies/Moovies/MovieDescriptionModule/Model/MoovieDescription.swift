// MoovieDescription.swift
// Copyright © Vera Malygina. All rights reserved.

import Foundation
import RealmSwift

/// необходимые данные для описания фильма
@objc class Description: Object, Codable {
    @objc dynamic var posterPath = String()
    @objc dynamic var title = String()
    @objc dynamic var overview = String()
    @objc dynamic var id = Int()

    override class func primaryKey() -> String? {
        "id"
    }
}
