//
//  HomeVC.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    let homeVM = HomeVM()
    var allRecipesModel: RecipesResponse?
    var errorMessage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupVM()
    }
    
    private func setupVM() {
        homeVM.getAllRecipes()
        
        homeVM.bindModelOnSuccess = {
            self.allRecipesModel = self.homeVM.model
            self.onSuccess()
        }
        homeVM.bindErrorOnFailure = {
            self.errorMessage = self.homeVM.errorMessage
            self.onFailure()
        }
    }
    
    private func onSuccess() {
        print(allRecipesModel)
    }
    
    private func onFailure() {
        print(errorMessage)
    }
    
}
