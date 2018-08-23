//
//  Storage.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 21.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation

let storage = Storage()

class Storage {
    func save() {
        print("save")
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: favoriteBooks)
        UserDefaults.standard.set(encodedData, forKey: "FavoriteBooks")
        UserDefaults.standard.set(favoriteSelectedArray, forKey: "FavoriteSelectedArray")
    }
    
    func load() {
        print("load")
        if let array = UserDefaults.standard.data(forKey: "FavoriteBooks") {
            favoriteBooks = (NSKeyedUnarchiver.unarchiveObject(with: array) as? [Book]) ?? []
            favoriteSelectedArray = UserDefaults.standard.object(forKey: "FavoriteSelectedArray") as? [Bool] ?? []
        }
    }
}
