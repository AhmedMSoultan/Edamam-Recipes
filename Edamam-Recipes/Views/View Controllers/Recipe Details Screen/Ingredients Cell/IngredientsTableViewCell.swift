//
//  IngredientsTableViewCell.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 20/08/2022.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {

    @IBOutlet weak var ingredientTitle: UILabel!
    
    static let cellIdentifier = "IngredientsTableViewCell"
    static let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupCell(title: String) {
        self.ingredientTitle.text = title
    }
    
}
