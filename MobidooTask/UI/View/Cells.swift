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

protocol UISuggestViewDelegate: class {
    func suggestPressed(id: Int)
}

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let starButton = UIButton(type: .system)
    weak var delegate: UIFavoriteViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Consts.isIpad ? titleLabel.font.withSize(22) : titleLabel.font.withSize(17)
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

class SuggestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var suggestImageView: UIImageView!
    
}

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteLabel.font = Consts.isIpad ? favoriteLabel.font.withSize(24) : favoriteLabel.font.withSize(17)
    }
}

class FirstPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Consts.isIpad ? titleLabel.font.withSize(25) : titleLabel.font.withSize(17)
        authorLabel.font = Consts.isIpad ? authorLabel.font.withSize(25) : authorLabel.font.withSize(17)
    }
}

class ContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentLabel.font = Consts.isIpad ? contentLabel.font.withSize(24) : contentLabel.font.withSize(17)
    }
}

class SliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var sliderImageView: UIImageView!
    
}
