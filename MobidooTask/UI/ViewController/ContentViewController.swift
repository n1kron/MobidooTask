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
    
    @IBOutlet weak var contentTableView: UITableView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var bookId: Int = 0
    var author: String = ""
    var cover: String = ""
    var bookTitle: String = ""
    var result = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ContentData.shared.getData(by: bookId)
        let shareButton = UIBarButtonItem(barButtonSystemItem:.action, target: self, action: #selector(shareButtonPressed))
        navigationItem.rightBarButtonItem = shareButton
        
        NotificationCenter.default.addObserver(forName: Notification.Name("content"), object: nil, queue: nil) { [weak self] (notification) in
            self?.result = ContentData.shared.contentText.splitByLength(TextScaleCalculator.use(), seperator: " ")
            self?.contentTableView.reloadData()
            self?.contentTableView.isHidden = false
            self?.activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        contentTableView.isHidden = true
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    @objc func shareButtonPressed() {
        Utiles.share(from: self)
    }
}

extension ContentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstPageTableViewCell", for: indexPath) as! FirstPageTableViewCell
            cell.authorLabel.text = author
            cell.titleLabel.text = bookTitle
            cell.coverImageView.kf.setImage(with: URL(string: cover), completionHandler: { (image, error, cacheType, imageUrl) in
            })
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: indexPath) as! ContentTableViewCell
            if result != [] {
                cell.contentTextView.text = result[indexPath.row - 1]
            }
            return cell
        }
    }
}
