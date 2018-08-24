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
    }
    
    func load() {
        print("load")
        if let array = UserDefaults.standard.data(forKey: "FavoriteBooks") {
            favoriteBooks = (NSKeyedUnarchiver.unarchiveObject(with: array) as? [Book]) ?? []
        }
    }
}
