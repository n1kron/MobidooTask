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
        return splittedStrings.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width , height: collectionView.bounds.size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstPageTableViewCell", for: indexPath) as! FirstPageCollectionViewCell
            cell.authorLabel.text = "Автор: \(author)"
            cell.titleLabel.text = bookTitle
            cell.coverImageView.kf.setImage(with: URL(string: cover), completionHandler: { (image, error, cacheType, imageUrl) in
            })
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentTableViewCell", for: indexPath) as! ContentCollectionViewCell
            if splittedStrings != [] {
                cell.contentLabel.textAlignment = .justified
                cell.contentLabel.text = splittedStrings[indexPath.row - 1]
            }
            return cell
        }
    }
}
