//
//  Repository.swift
//  Moovies
//
//  Created by Vera Zaitseva on 14.10.2021.
//

import Foundation

protocol DatabaseProtocol {

    func removeAll()
}

final class MoviesRealm: DatabaseProtocol {
    func getDescription(id: Int) -> [Description] {
        return []
    }

    func addDescription(object: [Description], id: Int) {}

    func get(movieType: MoviesType) -> [Movie] {
        return [Movie](
            repeating: .init(posterPath: "", overview: "", title: "", releaseDate: "", id: 0, voteAverage: 0),
            count: 10
        )
    }

    func add(object: [Movie], movieType: MoviesType) {}
    func remove(id: Int) {}
    func removeAll() {}
}

protocol Repositorable {
    func getMovie(movieType: MoviesType) -> [Movie]
    func getMovieDescription(id: Int) -> [Description]
    func save(obj: [Movie], movieType: MoviesType)
    func saveDescription(obj: [Description], id: Int)
    func deleteAll()
}

final class Repository: Repositorable {
    var dataBase: DatabaseProtocol
    init(dataBase: DatabaseProtocol) {
        self.dataBase = dataBase
    }

    func getMovie(movieType: MoviesType) -> [Movie] {
        return dataBase.get(movieType: movieType)
    }

    func getMovieDescription(id: Int) -> [Description] {
        return dataBase.getDescription(id: id)
    }

    func save(obj: [Movie], movieType: MoviesType) {
        dataBase.add(object: obj, movieType: movieType)
    }

    func saveDescription(obj: [Description], id: Int) {
        dataBase.addDescription(object: obj, id: id)
    }

    func deleteAll() {
        dataBase.removeAll()
    }
}
