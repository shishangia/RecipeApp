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

    private func fetchData() {
        APICalls.fetchAreas { categories in
            DispatchQueue.main.async {
                if let categories = categories {
                    self.data = categories
                    self.tableView.reloadData()
                } else {
                    print("Failed to fetch recipe")
                }
            }
        }
    }

    // MARK: UI Setup
    override func setupTableView() {
        super.setupTableView()
        self.tableView.register(SearchTableViewCell.self,
                                forCellReuseIdentifier: SearchTableViewCell.identifier)
    }

    private func setupSearchBar() {
        self.searchBar.delegate = self
    }

    override func setupUI() {
        super.setupUI()
        self.searchBar.placeholder = "Search Meals"
        navigationItem.titleView = searchBar
    }
}

extension SearchViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Unable to Deque Cell")
        }

        guard let category = data[indexPath.row] as? Category else {
            print("Error converting value")
            return cell
        }
        cell.configure(name: category.name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

        guard let category = data[indexPath.row] as? Category else {
            print("Error converting value")
            return
        }

        let viewController = MealsViewController(fetchType: .byArea(category.name))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // Dismiss the keyboard
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        let viewController = MealsViewController(fetchType: .bySearch(searchText))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
