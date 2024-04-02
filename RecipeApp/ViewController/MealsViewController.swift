//
//  MealsViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/29/24.
//

import UIKit

class MealsViewController: BaseViewController {

    // MARK: Variables
    let viewModel: MealsViewModel

    // MARK: Lifecycle
    init(fetchType: APICalls.FetchType) {
        self.viewModel = MealsViewModel(fetchType: fetchType)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.viewModel.setupNavigationTitle()
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
        self.viewModel.fetchData { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.collectionView.reloadData()
                if self.viewModel.meals.isEmpty {
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
}

// MARK: UICollectionView Delegates
extension MealsViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.meals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MealsCollectionViewCell.identifier,
            for: indexPath) as? MealsCollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }

        let meal = self.viewModel.meals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)

        let meal = self.viewModel.meals[indexPath.row]
        let viewController = RecipeDetailViewController(recipeID: meal.id)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
