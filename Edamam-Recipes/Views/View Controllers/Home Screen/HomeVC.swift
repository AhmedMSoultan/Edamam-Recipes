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
        self.setupView()
    }
    
    private func setupView() {
        recipesTableView.delegate = self
        recipesTableView.dataSource = self
        recipesTableView.register(RecipesTableViewCell.cellNib, forCellReuseIdentifier: RecipesTableViewCell.cellIdentifier)
        
        filtersCollectionView.delegate = self
        filtersCollectionView.dataSource = self
        filtersCollectionView.register(CategoriesCollectionViewCell.cellNib, forCellWithReuseIdentifier: CategoriesCollectionViewCell.cellIdentifier)
    }
    
    private func onSuccess() {
        self.allRecipesModel = homeVM.model
        self.tableHits = self.allRecipesModel?.hits ?? [Hits]()
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
        return tableHits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipeCell = recipesTableView.dequeueReusableCell(withIdentifier: RecipesTableViewCell.cellIdentifier, for: indexPath) as! RecipesTableViewCell
        if let recipe = tableHits[indexPath.row].recipe {
            recipeCell.setupCell(recipe: recipe)
        }
        return recipeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
}

extension HomeVC {
//    @objc func search()
//    {
//
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload), object: nil)
//        self.perform(#selector(self.reload), with: nil, afterDelay: 0.5)
//    }
    
//    @objc func reload() {
//        if let text = searchTF.text
//        {
//            if text.isEmpty{
//
//                resultArray.removeAll()
//                childView.isHidden = false
//                scrollViewOutlet.isHidden = false
//                searchTableView.isHidden = true
//                backBtnOutlet.tintColor = .opaqueSeparator
//            }
//            else
//            {
//            resultLabel.isHidden = true
//            childView.isHidden = true
//            scrollViewOutlet.isHidden = true
//            filterText(query: text)
//            searchText = text
//            backBtnOutlet.tintColor = UIColor(rgb: 0x8F63FF)
//
//            }
//        }
//    }
}
