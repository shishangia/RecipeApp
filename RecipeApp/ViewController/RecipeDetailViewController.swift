//
//  RecipeDetailViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/28/24.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: Variables
    let viewModel: RecipeDetailViewModel

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
        image.image = UIImage(systemName: "questionmark.circle")
        image.contentMode = .scaleAspectFill
        image.tintColor = UIColor(red: 244/255, green: 244/255, blue: 245/255, alpha: 1)
        image.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
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
    init(recipeID: String) {
        self.viewModel = RecipeDetailViewModel(recipeID: recipeID)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        self.setupUI()
        self.fetchData()
    }

    // MARK: Setup UI
    private func setupUI() {
        self.view.backgroundColor = .systemBackground

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
    }

    // MARK: Helper functions
    private func fetchData() {
        self.viewModel.fetchData { [weak self] in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.view.layoutIfNeeded()
                self.configure()
            }
        }
    }

    private func configure() {
        self.viewModel.fetchImage { [weak self] image in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.recipeImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.recipeImage.image = image
            }
        }
        let texts = self.viewModel.configureTexts()
        self.recipeName.text = texts.name
        self.recipeInstruction.attributedText = texts.instruction
        self.recipeIngredients.attributedText = texts.ingredients
        self.navigationItem.title = self.viewModel.recipe.name
    }
}
