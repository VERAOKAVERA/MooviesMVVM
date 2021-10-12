// MoovieDescription.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// необходимые данные для описания фильма
struct Description: Decodable {
    var posterPath: String
    let title: String
    let overview: String
}
