//
//  Extensions.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 24.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func splitByLength(_ length: Int, separator: String) -> [String] {
        var result = [String]()
        var collectedWords = [String]()
        collectedWords.reserveCapacity(length)
        var count = 0
        let words = self.components(separatedBy: " ")
        
        for word in words {
            count += word.count + 1
            if (count > length) {
                result.append(collectedWords.map { String($0) }.joined(separator: separator) )
                collectedWords.removeAll(keepingCapacity: true)
                count = word.count
                collectedWords.append(word)
            } else {
                collectedWords.append(word)
            }
        }
        
        if !collectedWords.isEmpty {
            result.append(collectedWords.map { String($0) }.joined(separator: separator))
        }
        return result
    }
}

extension MutableCollection {
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
