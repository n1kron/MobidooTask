//
//  ContentViewController.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 21.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Kingfisher

class ContentViewController: UIViewController {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var bookId: Int = 0
    var author: String = ""
    var cover: String = ""
    var bookTitle: String = ""
    var splittedStrings = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ContentData.shared.getData(by: bookId)
        let shareButton = UIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(shareButtonPressed))
        navigationItem.rightBarButtonItem = shareButton
    
        NotificationCenter.default.addObserver(forName: Notification.Name("content"), object: nil, queue: nil) { [weak self] (notification) in
            self?.splittedStrings = ContentData.shared.contentText.splitByLength(Int(UIScreen.main.bounds.size.height * 1.6), separator: " ")
            self?.contentCollectionView.reloadData()
            self?.contentCollectionView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentCollectionView.isHidden = true
        activityIndicator.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2 - (navigationController?.navigationBar.frame.height)!)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func shareButtonPressed() {
        let activityVC = UIActivityViewController(activityItems: ["String to share"], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
        if let popOver = activityVC.popoverPresentationController {
            popOver.sourceView = self.view
             Utiles.share(from: self)
        }
    }
}

extension ContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !SubscriptionManager.shared.isSubscriptionActive {
            NotificationCenter.default.addObserver(self, selector: #selector(handleInAppPurchase(notification:)), name: .SubscriptionStatusNotification, object: nil)
            return 1
        } else {
            return splittedStrings.count
        }
    }
    
    @objc func handleInAppPurchase(notification: Notification) {
        guard let result = notification.object as? Bool else  { return }
        
        if result {
           contentCollectionView.reloadData()
        } else {
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width , height: collectionView.bounds.size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !SubscriptionManager.shared.isSubscriptionActive {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstPageTableViewCell", for: indexPath) as! FirstPageCollectionViewCell
            cell.authorLabel.text = author
            cell.titleLabel.text = bookTitle
            let privacyPolicyTap = UITapGestureRecognizer(target: self, action: #selector(self.privacyPolicy(sender:)))
            let termOfUseTap = UITapGestureRecognizer(target: self, action: #selector(self.termOfUse(sender:)))
            cell.privacyPolicyLabel.isUserInteractionEnabled = true
            cell.privacyPolicyLabel.addGestureRecognizer(privacyPolicyTap)
            cell.termOfUseLabel.isUserInteractionEnabled = true
            cell.termOfUseLabel.addGestureRecognizer(termOfUseTap)
            
            cell.coverImageView.kf.setImage(with: URL(string: cover), completionHandler: { (image, error, cacheType, imageUrl) in
            })
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentTableViewCell", for: indexPath) as! ContentCollectionViewCell
            if splittedStrings != [] {
                cell.contentLabel.textAlignment = .justified
                cell.contentLabel.text = splittedStrings[indexPath.row]
            }
            return cell
        }
    }
    
    @objc func privacyPolicy(sender:UITapGestureRecognizer) {
        openUrl(urlString: "http://104.236.106.86/politics.html")
    }
    
    @objc func termOfUse(sender:UITapGestureRecognizer) {
        openUrl(urlString: "http://104.236.106.86/po.html")
    }
    
    func openUrl(urlString:String!) {
        let url = URL(string: urlString)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
