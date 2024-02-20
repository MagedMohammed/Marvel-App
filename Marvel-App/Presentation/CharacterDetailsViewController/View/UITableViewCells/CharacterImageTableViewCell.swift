//
//  CharacterImageTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import Kingfisher

class CharacterImageTableViewCell: UITableViewCell {

    //  MARK: - Outlet
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var characterImage: UIImageView!
    
    //  MARK: - Properties
    var backAction: (()->())?
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(image: String) {
        let url = URL(string: image)
        self.characterImage.kf.setImage(with: url)
    }
    
    //  MARK: - Action
    @IBAction func backAction(_ sender: UIButton) {
        self.backAction?()
    }
}
