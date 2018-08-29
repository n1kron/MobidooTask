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
        guard let url = URL(string: "https://itunes.apple.com/us/app/исламские-книги-читать-онлайн/id1434539304?l=ru&ls=1&mt=8") else {
            return
        }
        
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    static func share(from viewController: UIViewController) {
        let shareText = "https://itunes.apple.com/us/app/исламские-книги-читать-онлайн/id1434539304?l=ru&ls=1&mt=8"
        let vc = UIActivityViewController(activityItems: [shareText], applicationActivities: [])
        viewController.present(vc, animated: true)
    }
}
