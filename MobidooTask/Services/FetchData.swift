//
//  FetchData.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation
import Alamofire

class BooksData {
    var bookList: [Book] = []
    static let shared = BooksData()
    
    func getData() {
        Alamofire.request("http://knigo-lub.info/books/genres/221").responseJSON { [weak self] (response) in
            if let unparsedBooks = response.result.value as? [[String: Any]] {
                for book in unparsedBooks {
                    let bookList: Book = Book(dict: book)
                    self?.bookList.append(bookList)
                }
                NotificationCenter.default.post(name: Notification.Name("books"), object: nil)
            }
        }
    }
}

class ContentData {
    var contentText: String = ""
    static let shared = ContentData()
    
    func getData(by id: Int) {
        Alamofire.request("http://knigo-lub.info/books/contents/\(id)").responseJSON { [weak self] (response) in
            if let JSON = response.result.value {
                let json = JSON as! [String: Any]
                if let unparsedContent = json["content"] as? String {
                    self?.contentText = unparsedContent
                    NotificationCenter.default.post(name: Notification.Name("content"), object: nil)
                }
            }
        }
    }
}
