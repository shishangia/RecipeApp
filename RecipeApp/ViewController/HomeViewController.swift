//
//  HomeViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import UIKit

class HomeViewController: BaseViewController {

    // MARK: Variables
    let viewModel = HomeViewModel()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Home"
        self.fetchData()
    }

    // MARK: UI Setup
    override func setupCollectionView() {
        super.setupCollectionView()
        self.collectionView.register(CategoriesCollectionViewCell.self,
                                     forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
    }

    // MARK: Helper functions
    private func fetchData() {
        self.viewModel.fetchData { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: UICollectionView Delegates
extension HomeViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categories.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoriesCollectionViewCell.identifier,
            for: indexPath) as? CategoriesCollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }

        let category = self.viewModel.categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)

        let category = self.viewModel.categories[indexPath.row]
        let viewController = MealsViewController(fetchType: .byCategory(category.name))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
