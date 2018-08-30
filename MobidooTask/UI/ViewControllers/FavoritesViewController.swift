//
//  FavoritesViewController.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var explainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTableView.rowHeight = UITableViewAutomaticDimension
        favoriteTableView.estimatedRowHeight = 80
        favoriteTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Избранное"
        favoriteTableView.isHidden = favoriteBooks.isEmpty
        explainLabel.isHidden = !favoriteBooks.isEmpty
        favoriteTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let favoriteList = favoriteBooks[indexPath.row]
        cell.favoriteLabel.text = favoriteList.title
        cell.favoriteImageView.kf.setImage(with: URL(string: favoriteList.cover), completionHandler: { (image, error, cacheType, imageUrl) in
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "ShowContent", sender: favoriteBooks[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favoriteBooks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            explainLabel.isHidden = !favoriteBooks.isEmpty
        }
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

