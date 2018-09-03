//
//  PopularViewController.swift
//  IslamBook
//
//  Created by  Kostantin Zarubin on 29.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {
    @IBOutlet weak var popularTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popularTableView.rowHeight = UITableViewAutomaticDimension
        popularTableView.estimatedRowHeight = 80
        popularTableView.tableFooterView = UIView()
    }
}

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Consts.popularIds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = BooksData.shared.booksList.first(where: {$0.id == Consts.popularIds[indexPath.row]})
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
        cell.popularLabel.text = content?.title
        cell.popularImageView.kf.setImage(with: URL(string: (content?.cover)!), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowContent", sender: Consts.popularIds[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContent"{
            if let nextViewController = segue.destination as? ContentViewController {
                if let id = sender as? Int {
                    if let content = BooksData.shared.booksList.first(where: {$0.id == id}) {
                        nextViewController.bookId = id
                        nextViewController.cover = content.cover
                        nextViewController.author = content.author
                        nextViewController.bookTitle = content.title
                    }
                }
            }
        }
    }
}
