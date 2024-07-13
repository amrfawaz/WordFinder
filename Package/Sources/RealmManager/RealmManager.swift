//
//  RealmManager.swift
//
//
//  Created by AmrFawaz on 12/07/2024.
//

import Foundation
import RealmSwift

public class RealmManager {
    public static let shared = RealmManager()

    private init() {}

    private func createRealmInstance() -> Realm? {
        do {
            return try Realm()
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
            return nil
        }
    }

    public func save<T: Object>(_ items: [T]) {
        let backgroundQueue = DispatchQueue(
            label: "realmQueue",
            attributes: .concurrent
        )
        
        backgroundQueue.async {
            autoreleasepool {
                guard let realm = self.createRealmInstance() else { return }

                do {
                    try realm.write {
                        realm.add(items, update: .modified)
                    }
                } catch {
                    print("Error saving objects to Realm: \(error.localizedDescription)")
                }
            }
        }
    }

    public func deleteLast<T: Object>(_ item: T) {
        let backgroundQueue = DispatchQueue(
            label: "realmQueue",
            attributes: .concurrent
        )

        backgroundQueue.async {
            autoreleasepool {
                guard let realm = self.createRealmInstance() else { return }

                do {
                    try realm.write {
                        realm.delete(item)
                    }
                } catch {
                    print("Error saving objects to Realm: \(error.localizedDescription)")
                }
            }
        }
    }

    public func load<T: Object>(_ type: T.Type) -> [T] {
        guard let realm = self.createRealmInstance() else { return [] }

        let realmObjects = realm.objects(type)
        return Array(realmObjects)
    }
}
