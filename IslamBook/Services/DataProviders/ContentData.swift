//
//  ContentData.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 23.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation
import Alamofire

class ContentData {
    var contentText: String = ""
    static let shared = ContentData()
    
    func getData(by id: Int) {
        Alamofire.request("http://knigo-lub.info/books/contents/\(id)").responseJSON { [weak self] (response) in
            if let json = response.result.value as? [String: Any] {
                if let unparsedContent = json["content"] as? String {
                    self?.contentText = unparsedContent
                    NotificationCenter.default.post(name: Notification.Name("content"), object: nil)
                }
            }
        }
    }
}
