//
//  MainViewController.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit
import Kingfisher

class BooksListViewController: UIViewController {

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
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Главная"
        booksTableView.reloadData()
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

//MARK:- TableView
extension BooksListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BooksData.shared.booksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestTableViewCell", for: indexPath) as! SuggestTableViewCell
            cell.suggestCollectionView.delegate = self
            cell.suggestCollectionView.dataSource = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
            let book = BooksData.shared.booksList[indexPath.row]
            cell.delegate = self
            cell.titleLabel.text = book.title
            cell.starButton.isSelected = favoriteBooks.contains(book)
            cell.bookImageView.kf.setImage(with: URL(string: book.cover), completionHandler: { (image, error, cacheType, imageUrl) in
            })
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let book = BooksData.shared.booksList[indexPath.row]
        performSegue(withIdentifier: "ShowContent", sender: book.id)
    }
}

//MARK:- UIFavoriteViewDelegate
extension BooksListViewController: UIFavoriteViewDelegate {
    func favoritePressed(cell: UITableViewCell) {
        if let indexPathTapped = booksTableView.indexPath(for: cell) {
            let book = BooksData.shared.booksList[indexPathTapped.row]
            
            if favoriteBooks.contains(book) {
                if let index = favoriteBooks.index(of: book) {
                    favoriteBooks.remove(at: index)
                }
            } else {
                favoriteBooks.append(book)
            }
            storage.save()
        }
    }
}


//MARK:- Slider
extension BooksListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Consts.sliderBooks.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width , height: collectionView.bounds.size.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowContent", sender: Consts.sliderBooks.all[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.sliderImageView.image = UIImage(named: "slider\(indexPath.row)")
        return cell
    }
}


