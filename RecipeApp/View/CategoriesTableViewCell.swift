//
//  CategoriesTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/27/24.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    static let identifier = "CategoriesTableViewCell"

    // MARK: Variables
    private(set) var category: Category!

    // MARK: UI Componenets
    private let categoryImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let categoryName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()

    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with category: Category) {
        self.category = category
        self.categoryName.text = category.name

        guard let url = self.category.imageURL else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            DispatchQueue.main.async {
                self.categoryImage.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    // MARK: UI Setup
    private func setupUI() {
        self.addSubview(categoryName)
        self.addSubview(categoryImage)
//        self.backgroundColor = UIColor(red: 247/255, green: 226/255, blue: 168/255, alpha: 0.7)

        categoryName.translatesAutoresizingMaskIntoConstraints = false
        categoryImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            categoryImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            categoryImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),

            categoryName.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 16),
            categoryName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
