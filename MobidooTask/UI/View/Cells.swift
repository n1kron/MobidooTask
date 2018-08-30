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
        starButton.setBackgroundImage(#imageLiteral(resourceName: "star"), for: .normal)
        starButton.setBackgroundImage(#imageLiteral(resourceName: "star_pushed"), for: .selected)
        starButton.tintColor = .clear
        starButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        starButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        accessoryView = starButton
        
        if !Consts.isIpad {
            titleLabel.font = UIScreen.main.bounds.size.height == 568.0 ? titleLabel.font.withSize(15) : titleLabel.font.withSize(17)
        }
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
        if !Consts.isIpad {
            favoriteLabel.font = UIScreen.main.bounds.size.height == 568.0 ? favoriteLabel.font.withSize(15) : favoriteLabel.font.withSize(17)
        }
    }
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

class PopularTableViewCell: UITableViewCell {
    @IBOutlet weak var popularImageView: UIImageView!
    @IBOutlet weak var popularLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if !Consts.isIpad {
            popularLabel.font = UIScreen.main.bounds.size.height == 568.0 ? popularLabel.font.withSize(15) : popularLabel.font.withSize(17)
        }
    }
}

class NewTableViewCell: UITableViewCell {
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var newLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if !Consts.isIpad {
            newLabel.font = UIScreen.main.bounds.size.height == 568.0 ? newLabel.font.withSize(15) : newLabel.font.withSize(17)
        }
    }
}
