//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/28/24.
//

import UIKit
import WebKit

class RecipeDetailViewController: UIViewController {

    // MARK: Variables
    private var recipe: Recipe

    // MARK: UI Componenets

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        return view
    }()

    private let recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark")
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let recipeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()

    private let recipeIngredients: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "Error")
        return label
    }()

    private let recipeInstruction: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Error"
        return label
    }()

    private lazy var vStack: UIStackView = {
       let vStack = UIStackView(arrangedSubviews: [recipeName, recipeIngredients, recipeInstruction])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.distribution = .fill
        vStack.alignment = .leading
        return vStack
    }()

    // MARK: Lifecycle
    init(recipe: Recipe) {
        self.recipe = recipe
        super.init(nibName: nil, bundle: nil)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = self.recipe.name
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
    }

    // MARK: Setup UI
    private func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(recipeImage)
        self.contentView.addSubview(vStack)

        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.recipeImage.translatesAutoresizingMaskIntoConstraints = false
        self.vStack.translatesAutoresizingMaskIntoConstraints = false

        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            self.scrollView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor),
            self.scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
         
            self.contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            self.contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            self.recipeImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.recipeImage.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.recipeImage.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1),
            self.recipeImage.heightAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 9/16),

            self.vStack.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 16),
            self.vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.configure()
    }

    private func configure() {
        guard let url = self.recipe.imageURL else {
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
                self.recipeImage.image = UIImage(data: data)
            }
        }.resume()

        self.recipeName.text = self.recipe.name
        self.recipeInstruction.text = self.recipe.instruction

        let ingredientString = NSMutableAttributedString(string: "Ingredients: \n",
                                                         attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)])
        let boldAttribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)]
        let normalAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]
        for ingredient in self.recipe.ingredients {
            let boldText = ingredient.ingredient
            let boldString = NSAttributedString(string: boldText + ": ", attributes: boldAttribute)
            ingredientString.append(boldString)

            let normalString = NSAttributedString(string: ingredient.measure + "\n", attributes: normalAttribute)
            ingredientString.append(normalString)
        }
        self.recipeIngredients.attributedText = ingredientString
    }
}
