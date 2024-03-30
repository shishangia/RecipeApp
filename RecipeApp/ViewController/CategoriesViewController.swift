//
//  CategoriesViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/29/24.
//

import UIKit

class CategoriesViewController: UIViewController {

    // MARK: Variables
    private var meals: [Meal] = []
    private var categoryName: String

    // MARK: UI Componenets
    private let tableview: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(MealsTableViewCell.self, forCellReuseIdentifier: MealsTableViewCell.identifier)
        return table
    }()

    // MARK: Lifecycle

    init(meals: [Meal] = [], categoryName: String) {
        self.meals = meals
        self.categoryName = categoryName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    private func fetchData() {
        APICalls.fetchMeals(mealCategory: self.categoryName) { meals in
            DispatchQueue.main.async {
                if let meals = meals {
                    self.meals = meals
                    self.setupUI()
                } else {
                    print("Failed to fetch recipe")
                }
            }
        }
    }

    // MARK: UI Setup
    private func setupUI() {
        self.navigationItem.title = self.categoryName
        self.view.backgroundColor = .systemBackground

        self.view.addSubview(self.tableview)
        self.tableview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableview.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: MealsTableViewCell.identifier, for: indexPath) as? MealsTableViewCell else {
            fatalError("Unable to Deque Cell")
        }

        let meal = meals[indexPath.row]
        cell.configure(with: meal)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableview.deselectRow(at: indexPath, animated: true)

        APICalls.fetchRecipe(recipeID: meals[indexPath.row].id) { recipe in
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
