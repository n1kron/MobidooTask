//
//  SuggestCell+CollectionView.swift
//  MobidooTask
//
//  Created by  Kostantin Zarubin on 27.08.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    @IBOutlet weak var suggestCollectionView: UICollectionView!
    @IBOutlet weak var suggestLabel: UILabel!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    
    weak var delegate: UISuggestViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        suggestCollectionView.delegate = self
        suggestCollectionView.dataSource = self
        collectionHeightConstraint.constant = Consts.isIpad ? UIScreen.main.bounds.size.height * 0.3 : UIScreen.main.bounds.size.height * 0.18
        
        suggestLabel.font = Consts.isIpad ? suggestLabel.font.withSize(25) : suggestLabel.font.withSize(17)
    }
}

extension SuggestTableViewCell:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Consts.suggestBooks.all.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SuggestCollectionViewCell", for: indexPath) as! SuggestCollectionViewCell
        let bookId = Consts.suggestBooks.all[indexPath.row]
        if let book = BooksData.shared.booksList.first(where: {$0.id == bookId}) {
            cell.suggestImageView.kf.setImage(with: URL(string: book.cover), completionHandler: { (image, error, cacheType, imageUrl) in
            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width / 4, height: self.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width / 18.75, bottom: 0, right: UIScreen.main.bounds.size.width / 18.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.suggestPressed(id: Consts.suggestBooks.all[indexPath.row])
    }
}
