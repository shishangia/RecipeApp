//
//  SearchViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/30/24.
//

import UIKit

class SearchViewController: BaseViewController {

    // MARK: Variables
    private let searchBar = UISearchBar()
    private let viewModel = SearchViewModel()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSearchBar()
        self.navigationItem.title = "Search"
        self.fetchData()
    }

    // MARK: UI Setup
    override func setupCollectionView() {
        super.setupCollectionView()
        self.collectionView.register(SearchCollectionViewCell.self,
                                     forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }

    private func setupSearchBar() {
        self.searchBar.delegate = self
    }

    override func setupUI() {
        super.setupUI()
        self.searchBar.placeholder = "Search Meals"
        navigationItem.titleView = searchBar
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
extension SearchViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.areas.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath) as? SearchCollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }

        let area = self.viewModel.areas[indexPath.row]
        cell.configure(area: area)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)

        let area = self.viewModel.areas[indexPath.row]
        let viewController = MealsViewController(fetchType: .byArea(area.name))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: UISearchBar Delegates
extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        let viewController = MealsViewController(fetchType: .bySearch(searchText))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
