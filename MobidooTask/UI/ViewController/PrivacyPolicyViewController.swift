//
//  PrivacyPolicyViewController.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 26.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var privacyPolicyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Consts.isIpad {
            privacyPolicyTextView.font = privacyPolicyTextView.font?.withSize(25)
        }
    }
    
    override func viewDidLayoutSubviews() {
        privacyPolicyTextView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
}
