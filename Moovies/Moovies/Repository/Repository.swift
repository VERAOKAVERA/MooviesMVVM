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
    typealias Entity = DataBaseEntity
    func get(predicate: NSPredicate) -> [Entity]? {
        fatalError("Override required")
    }

    func save(object: [DataBaseEntity]) {
        fatalError("Override required")
    }
}

final class RealmRepository<RealmEntity: Object>: DataBaseRepository<RealmEntity> {
    typealias Entity = RealmEntity
    override func get(predicate: NSPredicate) -> [Entity]? {
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

//        do {
//            let realm = try Realm()
//            let objects = realm.objects(RealmEntity.self).filter(predicate)
//            var entites: [Entity]?
//            objects.forEach { movie in
//                (entites?.append(movie)) ?? (entites = [movie])
//            }
//            return entites
//        } catch {
//            return nil
//        }

    override func save(object: [Entity]) {
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
