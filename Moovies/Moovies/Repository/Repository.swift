// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func getMoviesList(of type: MovieListType) -> [Entity]
    func getDescription(of movieID: Int) -> [Entity]?
    func save(object: [Entity])
    func removeAll()
}

///
class Repository<DataBaseEntity>: RepositoryProtocol {
    typealias Entity = DataBaseEntity

    func getMoviesList(of type: MovieListType) -> [Entity] {
        fatalError("")
    }

    func save(object: [Entity]) {
        fatalError("")
    }

    func getDescription(of movieID: Int) -> [Entity]? {
        fatalError()
    }

    func removeAll() {}
}

/// а
class RealmRepository<RealmEntity: Object>: Repository<RealmEntity> {
    typealias Entity = RealmEntity

    override func save(object: [Entity]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)

            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print(error)
        }
    }

    override func getMoviesList(of type: MovieListType) -> [Entity] {
        do {
            let predicate = NSPredicate(format: "movieType == %@", String(type.urlPath))
            let realm = try Realm()
            let rez = realm.objects(Entity.self).filter(predicate)
            var mas: [Entity] = []
            rez.forEach {
                mas.append($0)
            }
            return mas
        } catch {
            return []
        }
    }

    override func getDescription(of movieID: Int) -> [Entity]? {
        do {
            let predicate = NSPredicate(format: "id == %i", movieID ?? 0)
            let realm = try Realm()
            let rez = realm.objects(Entity.self).filter(predicate)
            var mas: [Entity] = []
            rez.forEach {
                mas.append($0)
            }
            return mas
        } catch {
            return []
        }
    }
}
