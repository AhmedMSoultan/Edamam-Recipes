//
//  CategoriesCollectionViewCell.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryTitle: UILabel!
    
    static let cellIdentifier = "CategoriesCollectionViewCell"
    static let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
    var filterTitle = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(title: String) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.filterTitle = title
        categoryTitle.text = filterTitle
    }
    
    func setSelected() {
        self.backgroundColor = UIColor.label
        self.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        self.layer.borderWidth = 2
    }
    
    func setUnSelected() {
        self.backgroundColor = UIColor(named: "AccentColor")
        self.layer.borderWidth = 0
    }
}
