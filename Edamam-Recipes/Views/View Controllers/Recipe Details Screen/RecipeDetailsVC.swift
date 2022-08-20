//
//  RecipeDetailsVC.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import UIKit

class RecipeDetailsVC: UIViewController {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var ingredientNumber: UILabel!
    @IBOutlet weak var ingredientsTable: UITableView!
    
    @IBOutlet weak var recipeWebsiteBtn: UIButton!
    
    var cellRecipe: Recipe?
    var recipeIngredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    private func setupView(){
        ingredientsTable.dataSource = self
        ingredientsTable.delegate = self
        ingredientsTable.register(IngredientsTableViewCell.cellNib, forCellReuseIdentifier: IngredientsTableViewCell.cellIdentifier)
        
        recipeImage.layer.cornerRadius = 20
        backBtn.layer.cornerRadius = backBtn.frame.height / 2
        shareBtn.layer.cornerRadius = 10
        recipeWebsiteBtn.layer.cornerRadius = 10
        
        if let cellRecipe = cellRecipe {
            if let imageURL = cellRecipe.image {
                backgroundImage.setImageByKingFisher(url: imageURL , imageView: backgroundImage)
                recipeImage.setImageByKingFisher(url: imageURL, imageView: recipeImage)
            }
            
            if let recipeTitle = cellRecipe.title {
                self.recipeTitle.text = recipeTitle
            }
            
            if let recipeIngredients = cellRecipe.ingredientLines{
                self.recipeIngredients = recipeIngredients
                ingredientNumber.text = "\(recipeIngredients.count) Ingredients:"
            }
        }
            
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func shareBtnAction(_ sender: UIButton) {
        if let textToShare = cellRecipe?.shareAs {
            if let tokenURL = URL(string: textToShare) {
                let objectsToShare: [Any] = [tokenURL]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                // This lines is for the popover you need to show in iPad
                activityVC.popoverPresentationController?.sourceView = (sender)
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func recipeWebsiteBtnAction(_ sender: UIButton) {
        if let websiteURL = cellRecipe?.url {
            openWebsite(url: websiteURL)
        }
    }
    
    func openWebsite(url : String) {
        guard let url = URL(string: url) else{return}
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            //If you want handle the completion block than
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
//                print("Open url : \(success)")
            })
        }
    }
}

extension RecipeDetailsVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeIngredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredientCell = ingredientsTable.dequeueReusableCell(withIdentifier: IngredientsTableViewCell.cellIdentifier, for: indexPath) as! IngredientsTableViewCell
        if let ingredientLines = cellRecipe?.ingredientLines {
            ingredientCell.setupCell(title: ingredientLines[indexPath.row])
        }
        return ingredientCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
