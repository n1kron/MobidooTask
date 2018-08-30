//
//  Consts.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 26.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class Consts {
    
    static let isIpad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    static let popularIds: [Int] = [212989, 1327, 236400, 284447, 284475, 250688, 239259, 197373, 195679, 92870, 65519, 251534, 93025, 241776, 253403, 238323, 210519, 209829, 584480, 612943]
    
    struct sliderBooks {
        static let firstBook = 93025
        static let secondBook = 92870
        static let thirdBook = 20225
        
        static let all = [firstBook, secondBook, thirdBook]
    }
    
    struct suggestBooks {
        static let firstBook = 209829
        static let secondBook = 1327
        static let thirdBook = 584480
        static let fourthBook = 236397
        static let fifthBook = 197373
        static let sixthBook = 612943
        static let seventhBook = 212991
        
        static let all = [firstBook, secondBook, thirdBook, fourthBook, fifthBook, sixthBook, seventhBook]
    }
}

