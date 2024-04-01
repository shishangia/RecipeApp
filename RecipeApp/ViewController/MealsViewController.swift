//
//  MealsViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/29/24.
//

import UIKit

class MealsViewController: BaseViewController {

    // MARK: Enum

    // MARK: Variables
    private var fetchType: APICalls.FetchType

    // MARK: Lifecycle
    init(fetchType: APICalls.FetchType) {
        self.fetchType = fetchType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationTitle()
        self.fetchData()
    }

    // MARK: UI Setup
    override func setupCollectionView() {
        super.setupCollectionView()
        self.collectionView.register(MealsCollectionViewCell.self,
                                     forCellWithReuseIdentifier: MealsCollectionViewCell.identifier)
    }

    // MARK: Helper functions
    private func fetchData() {
        APICalls.fetchMeals(fetchType: fetchType) { meals in
            DispatchQueue.main.async {
                if let meals = meals {
                    self.data = meals
                    self.collectionView.reloadData()
                } else {
                    self.data = []
                    self.collectionView.reloadData()
                    let message = "No results found"
                    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

    private func setupNavigationTitle() {
        switch fetchType {
        case .byCategory(let categoryName):
            self.navigationItem.title = categoryName
        case .bySearch(let searchKey):
            self.navigationItem.title = "Search Results for \(searchKey)"
        case .byArea(let area):
            self.navigationItem.title = "Search Results for \(area)"
        }
    }
}

// MARK: UICollectionView Delegates
extension MealsViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MealsCollectionViewCell.identifier,
            for: indexPath) as? MealsCollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }

        guard let meal = data[indexPath.row] as? Meal else {
            print("Error converting value")
            return cell
        }
        cell.configure(with: meal)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)

        guard let meal = data[indexPath.row] as? Meal else {
            print("Error converting value")
            return
        }

        APICalls.fetchRecipe(recipeID: meal.id) { recipe in
            DispatchQueue.main.async {
                if let recipe = recipe {
                    let viewController = RecipeDetailViewController(recipe: recipe)
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    print("Failed to fetch recipe")
                }
            }
        }
    }
}
