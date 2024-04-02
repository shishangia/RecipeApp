//
//  RecipeDetailViewModel.swift
//  RecipeApp
//
//  Created by Shivam on 3/29/24.
//

import UIKit

class RecipeDetailViewModel {

    // MARK: Variables
    private let recipeID: String
    public var recipe = Recipe(id: "", name: "", instruction: "", ingredients: [])

    // MARK: Lifecycle
    init(recipeID: String) {
        self.recipeID = recipeID
    }

    // MARK: Fetch from API
    public func fetchData(completion: @escaping () -> Void) {
        APICalls.fetchRecipe(recipeID: self.recipeID) { [weak self] recipe in
            guard let self = self else { return }

            if let recipe = recipe {
                self.recipe = recipe
            } else {
                print("Failed to fetch recipe")
            }
            completion()
        }
    }

    // Public Funtions
    public func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let url = self.recipe.imageURL else {
            print("Invalid URL")
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }

    func configureTexts() -> (name: String?, instruction: NSAttributedString?, ingredients: NSAttributedString?) {
        let name = self.recipe.name

        let instructionString = NSMutableAttributedString(string: "Instructions: \n",
                                                         attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)])
        instructionString.append(NSAttributedString(string: self.recipe.instruction.replacingOccurrences(of: "\r\n", with: "\r\n\n")))

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
        return (name, instructionString, ingredientString)
    }
}
