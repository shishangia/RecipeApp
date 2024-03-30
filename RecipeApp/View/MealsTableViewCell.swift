//
//  MealsTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/30/24.
//

import UIKit

class MealsTableViewCell: UITableViewCell {
    
    static let identifier = "MealsTableViewCell"

    // MARK: Variables
    private(set) var meal: Meal!

    // MARK: UI Componenets
    private let mealImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let mealName: UILabel = {
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

    public func configure(with meal: Meal) {
        self.meal = meal
        self.mealName.text = meal.name

        guard let url = self.meal.imageURL else {
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
                self.mealImage.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    // MARK: UI Setup
    private func setupUI() {
        self.addSubview(mealName)
        self.addSubview(mealImage)
//        self.backgroundColor = UIColor(red: 247/255, green: 226/255, blue: 168/255, alpha: 0.7)

        mealName.translatesAutoresizingMaskIntoConstraints = false
        mealImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mealImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mealImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            mealImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            mealImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),

            mealName.leadingAnchor.constraint(equalTo: mealImage.trailingAnchor, constant: 16),
            mealName.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
