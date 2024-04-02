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
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let recipeName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let recipeIngredients: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.attributedText = NSAttributedString(string: "Error")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let recipeInstruction: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.attributedText = NSAttributedString(string: "Error")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var vStack: UIStackView = {
       let vStack = UIStackView(arrangedSubviews: [recipeName, recipeIngredients, recipeInstruction])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.distribution = .fill
        vStack.alignment = .leading
        vStack.backgroundColor = .white
        vStack.translatesAutoresizingMaskIntoConstraints = false
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

            self.vStack.topAnchor.constraint(equalTo: recipeImage.bottomAnchor),
            self.vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),

            self.recipeName.topAnchor.constraint(equalTo: self.vStack.topAnchor, constant: 12),
            self.recipeName.leadingAnchor.constraint(equalTo: self.vStack.leadingAnchor, constant: 12),
            self.recipeName.trailingAnchor.constraint(equalTo: self.vStack.trailingAnchor, constant: -12),

            self.recipeIngredients.leadingAnchor.constraint(equalTo: self.recipeName.leadingAnchor),
            self.recipeIngredients.trailingAnchor.constraint(equalTo: self.recipeName.trailingAnchor),

            self.recipeInstruction.leadingAnchor.constraint(equalTo: self.recipeName.leadingAnchor),
            self.recipeInstruction.trailingAnchor.constraint(equalTo: self.recipeName.trailingAnchor)
        ])
        self.configure()
    }

    // MARK: Helper functions
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
        let instructionString = NSMutableAttributedString(string: "Instructions: \n",
                                                         attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        instructionString.append(NSAttributedString(string: self.recipe.instruction))
        self.recipeInstruction.attributedText = instructionString

        let ingredientString = NSMutableAttributedString(string: "Ingredients: \n",
                                                         attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        let boldAttribute = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
        let normalAttribute = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]
        for ingredient in self.recipe.ingredients {
            let boldText = ingredient.ingredient
            let boldString = NSAttributedString(string: "  • " + boldText + ": ", attributes: boldAttribute)
            ingredientString.append(boldString)

            let normalText = ingredient == self.recipe.ingredients.last ? ingredient.measure : ingredient.measure + "\n"
            let normalString = NSAttributedString(string: normalText, attributes: normalAttribute)
            ingredientString.append(normalString)
        }
        self.recipeIngredients.attributedText = ingredientString
    }
}
