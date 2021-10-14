// Repository.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
    func get(predicate: NSPredicate) -> [Entity]?
    func save(object: [Entity])
}

/// Абстракция над репозиторием
class DataBaseRepository<DataBaseEntity>: RepositoryProtocol {
    func get(predicate: NSPredicate) -> [DataBaseEntity]? {
        fatalError("Override required")
    }

    func save(object: [DataBaseEntity]) {
        fatalError("Override required")
    }
}

final class RealmRepository<RealmEntity: Object>: DataBaseRepository<RealmEntity> {
    override func get(predicate: NSPredicate) -> [RealmEntity]? {
        do {
            let realm = try Realm()
            let objects = realm.objects(RealmEntity.self).filter(predicate)
            var entites: [Entity]?
            objects.forEach { movie in
                (entites?.append(movie)) ?? (entites = [movie])
            }
            return entites
        } catch {
            return nil
        }
    }

    override func save(object: [RealmEntity]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object)
            try realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
}
