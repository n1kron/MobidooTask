//
//  MainViewController.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage.load()
        BooksData.shared.getData()
        booksTableView.isHidden = true
        booksTableView.rowHeight = UITableViewAutomaticDimension
        booksTableView.estimatedRowHeight = 80
        NotificationCenter.default.addObserver(forName: Notification.Name("books"), object: nil, queue: nil) { [weak self] (notification) in
            self?.booksTableView.isHidden = false
            self?.booksTableView.reloadData()
            
            if favoriteSelectedArray.isEmpty {
                for _ in 0...BooksData.shared.bookList.count {
                    favoriteSelectedArray.append(false)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Главная"
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BooksData.shared.bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        let bookList = BooksData.shared.bookList[indexPath.row]
        cell.delegate = self
        cell.titleLabel.text = bookList.title
        cell.starButton.isSelected = favoriteSelectedArray[indexPath.row]
        cell.bookImageView.kf.setImage(with: URL(string: bookList.cover), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowContent", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContent" {
            if let nextViewController = segue.destination as? ContentViewController {
                let content = BooksData.shared.bookList[(sender as! IndexPath).row]
                nextViewController.bookId = content.id
                nextViewController.cover = content.cover
                nextViewController.author = content.author
                nextViewController.bookTitle = content.title
            }
        }
    }
}

extension MainViewController: UIFavoriteViewDelegate {
    func favoritePressed(cell: UITableViewCell) {
        if let indexPathTapped = booksTableView.indexPath(for: cell) {
            let book = BooksData.shared.bookList[indexPathTapped.row]
            
            if favoriteBooks.contains(where: {$0.id == book.id}) {
                favoriteBooks = favoriteBooks.filter {$0.id != book.id}
                favoriteSelectedArray[indexPathTapped.row] = false
            } else {
                favoriteBooks.append(book)
                favoriteSelectedArray[indexPathTapped.row] = true
            }
            
            storage.save()
            NotificationCenter.default.post(name: Notification.Name("favorite"), object: nil)
        }
    }
}

