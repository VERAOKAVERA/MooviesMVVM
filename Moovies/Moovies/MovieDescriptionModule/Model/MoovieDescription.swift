//
//  MovieDescription.swift
//  Moovies
//
//  Created by Vera Zaitseva on 17.08.2021.
//

import Foundation

// необходимые данные для описания фильма
struct Description: Decodable {
    var posterPath: String?
    let title: String
    let overview: String
}
