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
        APICalls.fetchAreas { areas in
            DispatchQueue.main.async {
                if let areas = areas {
                    self.data = areas
                    self.collectionView.reloadData()
                } else {
                    print("Failed to fetch recipe")
                }
            }
        }
    }
}

// MARK: UICollectionView Delegates
extension SearchViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SearchCollectionViewCell.identifier,
            for: indexPath) as? SearchCollectionViewCell else {
            fatalError("Unable to Deque Cell")
        }

        guard let area = data[indexPath.row] as? Area else {
            print("Error converting value")
            return cell
        }
        cell.configure(area: area)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)

        guard let area = data[indexPath.row] as? Area else {
            print("Error converting value")
            return
        }

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
