//
//  CategoryTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/27/24.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "CategoryTableViewCell"

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
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 1
        label.text = "Error"
        return label
    }()

    private let categoryDesciption: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .regular)
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
        self.categoryDesciption.text = category.description

//        if let imageData = try? Data(contentsOf: self.category.imageURL!) {
//            DispatchQueue.main.async { [weak self] in
//                self?.categoryImage.image = UIImage(data: imageData)
//            }
//        }

        guard let url = self.category.imageURL else {
            print("Invalid URL")
            return
        }

        let _: Void = URLSession.shared.dataTask(with: url) { (data, response, error) in
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
        }.resume()
    }

    // MARK: UI Setup
    private func setupUI() {
        self.addSubview(categoryName)
        self.addSubview(categoryDesciption)
        self.addSubview(categoryImage)

        categoryName.translatesAutoresizingMaskIntoConstraints = false
        categoryDesciption.translatesAutoresizingMaskIntoConstraints = false
        categoryImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            categoryImage.widthAnchor.constraint(equalToConstant: 80),
            categoryImage.heightAnchor.constraint(equalToConstant: 80),

            categoryName.topAnchor.constraint(equalTo: categoryImage.topAnchor, constant: 8),
            categoryName.leadingAnchor.constraint(equalTo: categoryImage.trailingAnchor, constant: 4),

            categoryDesciption.topAnchor.constraint(equalTo: categoryName.bottomAnchor, constant: 2),
            categoryDesciption.leadingAnchor.constraint(equalTo: categoryName.leadingAnchor),
            categoryDesciption.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
