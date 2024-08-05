//
//  CollectionViewCell.swift
//  MyMoviesD
//
//  Created by Briam Cano on 02/08/24.
//

import UIKit
import SDWebImage

class UpcomingCollectionCell: UICollectionViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 0.5
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = true
    }

    override func prepareForReuse() {
        movieImg.image = nil
        lblTitle.text = nil
    }
    
    func setupCollectionCell(movieImg: String, title: String) {
        self.movieImg.sd_setImage(with: URL(string: movieImg), placeholderImage: UIImage.placeholderError)
        self.lblTitle.text = title
    }
}

