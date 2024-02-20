//
//  CharactersListTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 18/02/2024.
//

import UIKit
import Kingfisher

class CharactersListTableViewCell: UITableViewCell {
    //  MARK: - Outlet
    
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTitle: UIButton!
    
    //  MARK: - Properties
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(title: String, image: String) {
        self.characterTitle.setTitle(title, for: .normal)
        let url = URL(string: image)
        self.characterImage.kf.setImage(with: url)
    }
    
    //  MARK: - Action
    
}
