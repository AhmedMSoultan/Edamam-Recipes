//
//  HomeVC.swift
//  Edamam-Recipes
//
//  Created by Ahmed Soultan on 18/08/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var filtersCollectionView: UICollectionView!
    @IBOutlet weak var recipesTableView: UITableView!
    
    
    let homeVM = HomeVM()
    var allRecipesModel: RecipesResponse?
    var errorMessage: String?
    var tableHits = [Hits]()
    var filteredTableHits = [Hits]()
    var filter = false
    
    let filters = ["All",
                   "alcohol-cocktail",
                   "alcohol-free",
                   "celery-free",
                   "crustacean-free",
                   "dairy-free",
                   "DASH",
                   "egg-free",
                   "fish-free",
                   "fodmap-free",
                   "gluten-free",
                   "immuno-supportive",
                   "keto-friendly",
                   "kidney-friendly",
                   "kosher",
                   "low-fat-abs",
                   "low-potassium",
                   "low-sugar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hideKeyboardWhenTappedAround()
        setupVM()
        searchTF.keyboardType = UIKeyboardType.alphabet
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
        self.setupView()
    }
    
    private func setupView() {
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(RecipesTableViewCell.cellNib, forCellReuseIdentifier: RecipesTableViewCell.cellIdentifier)
        
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        filtersCollectionView.register(CategoriesCollectionViewCell.cellNib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier)
        
        searchTF.delegate = self
    }
    
    private func onSuccess() {
        self.allRecipesModel = homeVM.model
        self.tableHits = self.allRecipesModel?.hits ?? [Hits]()
        self.filteredTableHits = self.tableHits
        DispatchQueue.main.async {
            self.recipesTableView.reloadData()
        }
    }
    
    private func onFailure() {
        let alert = UIAlertController(title: "Error",
                          message: "Failed to fetch data from server",
                          preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
}

extension HomeVC: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !filteredTableHits.isEmpty {
            return filteredTableHits.count
        }
        return filter ? 0 : tableHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipeCell = recipesTableView.dequeueReusableCell(withIdentifier: RecipesTableViewCell.cellIdentifier, for: indexPath) as! RecipesTableViewCell
        
        if !filteredTableHits.isEmpty {
            if let recipe = filteredTableHits[indexPath.row].recipe {
                recipeCell.setupCell(recipe: recipe)
            }
        } else {
            if let recipe = tableHits[indexPath.row].recipe {
                recipeCell.setupCell(recipe: recipe)
            }
        }
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = recipesTableView.cellForRow(at: indexPath) as! RecipesTableViewCell
        let cellRecipe = cell.cellRecipe
        
        let detailsVC = RecipeDetailsVC()
        detailsVC.cellRecipe = cellRecipe
        
        detailsVC.modalTransitionStyle = .crossDissolve
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let filterCell = filtersCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        filterCell.setupCell(title: filters[indexPath.item])
        return filterCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filterCell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        filterCell.setSelected()
        if filterCell.filterTitle != "All" {
            self.homeVM.getFilteredRecipes(filterBy: filterCell.categoryTitle.text ?? "")
        } else {
            self.homeVM.getAllRecipes()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let filterCell = collectionView.cellForItem(at: indexPath) as! CategoriesCollectionViewCell
        filterCell.setUnSelected()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 40)
    }
}

extension HomeVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters.union(CharacterSet(charactersIn: " "))
        let characterSet = CharacterSet(charactersIn: string)
        
        if let text = textField.text{
            if (string.count == 1){
                filterText(text: text + string)
            } else {
                if text.count > 2 {
                    filterText(text: text)
                } else if text.count == 2{
                    filterText(text: text.first!.description)
                }
                else {
                    filterText(text: string)
                }
            }
        }
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func filterText(text: String){
        filteredTableHits.removeAll()
        for tableHit in tableHits {
            if let recipeTitle = tableHit.recipe?.title {
                if recipeTitle.lowercased().starts(with: text.lowercased()){
                    filteredTableHits.append(tableHit)
                } else {
                    if let recipeIngredients = tableHit.recipe?.ingredientLines {
                        for ingredient in recipeIngredients {
                            if ingredient.lowercased().starts(with: text.lowercased()) {
                                filteredTableHits.append(tableHit)
                                break
                            }
                        }
                    }
                }
            }
        }
        
        if text != "" {
            filter = true
        } else {
            filter = false
        }
        recipesTableView.reloadData()
    }
}
