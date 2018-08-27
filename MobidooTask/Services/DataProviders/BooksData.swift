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
    var booksList: [Book] = []
    static let shared = BooksData()
    
    func getData() {
        Alamofire.request("http://knigo-lub.info/books/genres/225").responseJSON { [weak self] (response) in
            if let unparsedBooks = response.result.value as? [[String: Any]] {
                self?.booksList.removeAll()
                for book in unparsedBooks {
                    let bookList: Book = Book(dict: book)
                    self?.booksList.append(bookList)
                }
                NotificationCenter.default.post(name: Notification.Name("books"), object: nil)
            }
        }
    }
}
