//
//  ComicTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import Kingfisher

class ComicTableViewCell: UITableViewCell {

    //  MARK: - Outlet
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    //  MARK: - Properties
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(name: String, image: String) {
        self.nameLabel.text = name
        let url = URL(string: image)
        self.comicImage.kf.setImage(with: url)
    }
    //  MARK: - Action
    
}
