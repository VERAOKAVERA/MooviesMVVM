// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(predicate: NSPredicate) -> [Entity]
    func save(object: [Entity])
    func removeAll()
}

///
class Repository<DataBaseEntity>: RepositoryProtocol {
    typealias Entity = DataBaseEntity

    func get(predicate: NSPredicate) -> [Entity] {
        fatalError("")
    }

    func save(object: [Entity]) {
        fatalError("")
    }

    func removeAll() {}
}

final class RealmRepository<RealmEntity: Object>: Repository<RealmEntity> {
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

    override func get(predicate: NSPredicate) -> [Entity] {
        do {
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
