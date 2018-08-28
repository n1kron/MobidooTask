//
//  OnboardingViewController.swift
//  IslamBook
//
//  Created by  Kostantin Zarubin on 28.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var onboardingScrollView: UIScrollView!
    var transitionСompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingScrollView.delegate = self
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.width + scrollView.contentInset.right + 10 && !transitionСompleted {
            transitionСompleted = true
            performSegue(withIdentifier: "ShowApp", sender: nil)
        }
    }
}
