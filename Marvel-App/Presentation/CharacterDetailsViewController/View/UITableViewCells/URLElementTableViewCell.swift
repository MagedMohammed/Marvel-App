//
//  URLElementTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 19/02/2024.
//

import UIKit

class URLElementTableViewCell: UITableViewCell {
    //  MARK: - Outlet
    @IBOutlet weak var titleLabel: UILabel!
    
    //  MARK: - Properties
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(title: String) {
        self.titleLabel.text = title
    }
    //  MARK: - Action
    
}
