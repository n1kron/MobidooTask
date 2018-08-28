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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingScrollView.delegate = self
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView)  {
        print(scrollView.contentOffset.x)
        if scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.bounds.width + scrollView.contentInset.right + 10 {
            performSegue(withIdentifier: "ShowApp", sender: nil)
        }
    }
}
