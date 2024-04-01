//
//  BaseViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/30/24.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Variables
    public var data: [Any] = []

    // MARK: UI Componenets
    public let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        return table
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupUI()
    }

    // MARK: UI Setup
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
    }

    public func setupUI() {
        self.view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDataSource
extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
