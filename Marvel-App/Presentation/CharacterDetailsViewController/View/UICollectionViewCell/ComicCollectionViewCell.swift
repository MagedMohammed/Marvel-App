//
//  ComicCollectionViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import Kingfisher

class ComicCollectionViewCell: UICollectionViewCell {

    //  MARK: - Outlet
    @IBOutlet weak private var comicImage: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    //  MARK: - Properties
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(title: String, image: String) {
        self.nameLabel.text = title
        let url = URL(string: image)
        self.comicImage.kf.setImage(with: url, placeholder: UIImage(named: "marvel-logo-2D20B064BD-seeklogo.com"))
    }
    
    //  MARK: - Action

}
