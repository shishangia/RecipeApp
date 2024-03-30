//
//  ViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Variables
    private var categories: [Category] = []

    // MARK: UI Componenets
    private let tableview: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(CategoriesTableViewCell.self, forCellReuseIdentifier: CategoriesTableViewCell.identifier)
        return table
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    private func fetchData() {
        APICalls.fetchCategories { categories in
            DispatchQueue.main.async {
                if let categories = categories {
                    self.categories = categories
                    self.setupUI()
                } else {
                    print("Failed to fetch recipe")
                }
            }
        }
    }

    // MARK: UI Setup
    private func setupUI() {
        self.navigationItem.title = "Home"
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

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else {
            fatalError("Unable to Deque Cell")
        }

        let category = categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableview.deselectRow(at: indexPath, animated: true)
        let viewController = CategoriesViewController(categoryName: categories[indexPath.row].name)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

