//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        self.fetchData()
    }

    private func fetchData() {
        APICalls.fetchCategories { categories in
            DispatchQueue.main.async {
                if let categories = categories {
                    self.data = categories
                    self.collectionView.reloadData()
                } else {
                    print("Failed to fetch recipe")
                }
            }
        }
    }

    // MARK: UI Setup
    override func setupCollectionView() {
        super.setupCollectionView()
        self.collectionView.register(CategoriesCollectionViewCell.self,
                                     forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }
}

// MARK: UICollectionView Delegates
extension HomeViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.identifier,
            for: indexPath) as? CategoriesCollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }

        guard let category = data[indexPath.row] as? Category else {
            print("Error converting value")
            return cell
        }
        cell.configure(with: category)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)

        guard let category = data[indexPath.row] as? Category else {
            print("Error converting value")
            return
        }

        let viewController = MealsViewController(fetchType: .byCategory(category.name))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
