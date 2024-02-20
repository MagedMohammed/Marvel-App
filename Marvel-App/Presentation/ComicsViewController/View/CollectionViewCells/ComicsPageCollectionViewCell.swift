//
//  ComicsPageCollectionViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import Kingfisher

class ComicsPageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var comicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(image: String) {
        let url = URL(string: image)
        self.comicImage.kf.setImage(with: url)
    }
}
