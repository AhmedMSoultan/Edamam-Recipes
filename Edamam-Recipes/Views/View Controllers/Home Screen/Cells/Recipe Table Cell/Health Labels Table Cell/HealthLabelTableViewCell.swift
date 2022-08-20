//
//  HealthLabelTableViewCell.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 20/08/2022.
//

import UIKit

class HealthLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var healthlabelName: UILabel!
    
    static let cellIdentifier = "HealthLabelTableViewCell"
    static let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupCell(healthlabelName: String) {
        self.healthlabelName.text = healthlabelName
    }
    
}
