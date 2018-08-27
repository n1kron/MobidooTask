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
        
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
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
