//
//  Book.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation

var favoriteBooks: [Book] = []
var favoriteSelectedArray: [Bool] = []

class Book: NSObject, NSCoding {
    let id: Int
    let title: String
    let author: String
    let cover: String

    init(dict: [String: Any]) {
        title = dict["title"] as? String ?? ""
        author = dict["author"] as? String ?? ""
        cover = dict["cover"] as? String ?? ""
        id = dict["id"] as? Int ?? 0
    }
    
    required init(coder decoder: NSCoder) {
        self.title = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.author = decoder.decodeObject(forKey: "author") as? String ?? ""
        self.cover = decoder.decodeObject(forKey: "cover") as? String ?? ""
        self.id = decoder.decodeInteger(forKey: "id")
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(author, forKey: "author")
        aCoder.encode(cover, forKey: "cover")
        aCoder.encode(id, forKey: "id")
    }
}
