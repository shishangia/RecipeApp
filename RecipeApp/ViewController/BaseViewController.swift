//
//  ViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Variables
    private let categories: [Category] = Category.mock()

    // MARK: UI Componenets
    private let tableview: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        return table
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.tableview.delegate = self
        self.tableview.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        let categoriesViewModel = CategoriesViewModel()
//        categoriesViewModel.fetchDataFromAPI()
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
            self.tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension BaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
            fatalError("Unable to Deque Cell")
        }

        let category = categories[indexPath.row]
        cell.configure(with: category)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

