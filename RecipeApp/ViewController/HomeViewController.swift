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
        self.tableView.register(CategoriesTableViewCell.self,
                                forCellReuseIdentifier: CategoriesTableViewCell.identifier)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else {
            fatalError("Unable to Deque Cell")
        }

        guard let category = data[indexPath.row] as? Category else {
            print("Error converting value")
            return cell
        }
        cell.configure(with: category)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)

        guard let category = data[indexPath.row] as? Category else {
            print("Error converting value")
            return
        }

        let viewController = MealsViewController(fetchType: .byCategory(category.name))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
