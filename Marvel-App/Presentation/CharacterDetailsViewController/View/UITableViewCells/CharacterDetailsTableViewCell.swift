//
//  CharacterDetailsTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit

class CharacterDetailsTableViewCell: UITableViewCell {
    
    //  MARK: - Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //  MARK: - Properties
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(name: String, description: String) {
        self.nameLabel.text = name
        self.descriptionLabel.text = description
    }
    //  MARK: - Action
    
}
