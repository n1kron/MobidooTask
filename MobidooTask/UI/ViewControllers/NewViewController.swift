//
//  NewViewController.swift
//  IslamBook
//
//  Created by  Kostantin Zarubin on 29.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    @IBOutlet weak var newTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BooksData.shared.newList.shuffle()
        newTableView.rowHeight = UITableViewAutomaticDimension
        newTableView.estimatedRowHeight = 80
        newTableView.tableFooterView = UIView()
    }
}

extension NewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BooksData.shared.newList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let content = BooksData.shared.booksList.first(where: {$0.id == BooksData.shared.newList[indexPath.row]})
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewTableViewCell", for: indexPath) as! NewTableViewCell
        cell.newLabel.text = content?.title
        cell.newImageView.kf.setImage(with: URL(string: (content?.cover)!), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowContent", sender: BooksData.shared.newList[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContent" {
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
