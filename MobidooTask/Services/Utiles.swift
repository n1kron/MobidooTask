//
//  Utils.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation
import StoreKit

class Utiles {
    
    static func rate() {
        
        guard let url = URL(string: "") else { //add string url to app: itms-apps://itunes.apple.com/...
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func share(from viewController: UIViewController) {
        let shareText = "" //add string url to app: itms-apps://itunes.apple.com/...
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        viewController.present(vc, animated: true)
    }
}

class TextScaleCalculator {
    static func use() -> Int {
        let height = UIScreen.main.bounds.size.height
        switch height {
        case 568.0: //iphone 5 5s SE => 4 inch
            return 900
        case 667.0: //iphone 6 6s 7 8 => 4.7 inch
            return 1300
        case 736.0: //iphone 6s+ 6+ 7+ 8+ => 5.5 inch
            return 1400
        case 812.0: //iphone X => 5.8 inch
            return 1400
        default:
            return 900
        }
    }
}

extension String {
    func splitByLength(_ length: Int, seperator: String) -> [String] {
        var result = [String]()
        var collectedWords = [String]()
        collectedWords.reserveCapacity(length)
        var count = 0
        let words = self.components(separatedBy: " ")
        
        for word in words {
            count += word.count + 1
            if (count > length) {
                result.append(collectedWords.map { String($0) }.joined(separator: seperator) )
                collectedWords.removeAll(keepingCapacity: true)
                count = word.count
                collectedWords.append(word)
            } else {
                collectedWords.append(word)
            }
        }
        
        if !collectedWords.isEmpty {
            result.append(collectedWords.map { String($0) }.joined(separator: seperator))
        }
        return result
    }
}
