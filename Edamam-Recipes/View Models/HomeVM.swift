//
//  HomeVM.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import Foundation

class HomeVM{
    
    var networkLayer: NetworkLayer = .shared
    
    var bindModelOnSuccess: ()->() = {}
    var bindErrorOnFailure: ()->() = {}
    
    
    var model: RecipesResponse! {
        didSet {
            bindModelOnSuccess()
        }
    }
    
    var errorMessage: String! {
        didSet {
            bindErrorOnFailure()
        }
    }
    
    func getAllRecipes() {
        networkLayer.get(endPoint: .all, className: RecipesResponse.self) { response in
            switch response {
            case .success(let data):
                self.model = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getFilteredRecipes(filterBy: String) {
        networkLayer.get(endPoint: .filterByHealth(filterBy), className: RecipesResponse.self) { response in
            switch response {
            case .success(let data):
                self.model = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
