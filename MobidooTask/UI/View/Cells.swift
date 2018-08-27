//
//  BookTableViewCell.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 20.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

protocol UIFavoriteViewDelegate: class {
    func favoritePressed(cell: UITableViewCell)
}

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let starButton = UIButton(type: .system)
    weak var delegate: UIFavoriteViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starButton.setBackgroundImage(#imageLiteral(resourceName: "star"), for: .normal)
        starButton.setBackgroundImage(#imageLiteral(resourceName: "star_pushed"), for: .selected)
        starButton.tintColor = .clear
        starButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        starButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        accessoryView = starButton
    }
    
    @objc func handleFavorite() {
        starButton.isSelected = starButton.isSelected ? false : true
        delegate?.favoritePressed(cell: self)
    }
}

class SuggestTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var suggestCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        suggestCollectionView.delegate = self
        suggestCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Consts.suggestBooks.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestCollectionViewCell", for: indexPath) as! SuggestCollectionViewCell
        let bookID = Consts.suggestBooks.all[indexPath.row]
//        cell.suggestImageView.kf.setImage(with: URL(string: book.cover), completionHandler: { (image, error, cacheType, imageUrl) in
//        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

class SuggestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var suggestImageView: UIImageView!
}

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
}

class FirstPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
}

class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
}

class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sliderImageView: UIImageView!
}
