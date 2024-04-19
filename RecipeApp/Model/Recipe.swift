//
//  Recipe.swift
//  RecipeApp
//
//  Created by Shivam on 3/28/24.
//

import Foundation

struct Recipe {

    // MARK: Variables
    var id: String
    var name: String
    var instruction: String
    var ingredients: [Ingredient]

    var imageURL = {
        return URL(string: "https://www.themealdb.com/images/ingredients/Lime-Small.png")
    }()

    // MARK: Setter
    mutating func setImageURL(_ url: URL?) {
        imageURL = url
    }
}

struct Ingredient: Equatable {

    // MARK: Variables
    let ingredient: String
    let measure: String

    // MARK: Equatable Protocol
    static func ==(lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.ingredient == rhs.ingredient && lhs.measure == rhs.measure
    }
}
