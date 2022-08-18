//
//  RecipesTableViewCell.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "RecipesTableViewCell"
    static let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
