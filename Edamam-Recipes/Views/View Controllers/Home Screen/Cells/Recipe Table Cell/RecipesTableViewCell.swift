//
//  RecipesTableViewCell.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeSource: UILabel!
    @IBOutlet weak var healthLabelTable: UITableView!
    
    static let cellIdentifier = "RecipesTableViewCell"
    static let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
    var cellRecipe: Recipe?
    var healthLabels = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        healthLabelTable.delegate = self
        healthLabelTable.dataSource = self
        healthLabelTable.register(HealthLabelTableViewCell.cellNib, forCellReuseIdentifier: HealthLabelTableViewCell.cellIdentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setupCell(recipe: Recipe) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 7
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.label.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height: 3 )
        
        cellRecipe = recipe
        
        if let imageURL = recipe.image {
            recipeImage.setImageByKingFisher(url: imageURL, imageView: recipeImage)
        } else {
            recipeImage.image = UIImage(systemName: "leaf")
        }
        recipeTitle.text = recipe.title ?? ""
        recipeSource.text = recipe.source ?? ""
        self.healthLabels = recipe.healthLabels ?? [String]()
    }
    
}

extension RecipesTableViewCell: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return healthLabels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = healthLabelTable.dequeueReusableCell(withIdentifier: HealthLabelTableViewCell.cellIdentifier, for: indexPath) as! HealthLabelTableViewCell
        cell.setupCell(healthlabelName: healthLabels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
