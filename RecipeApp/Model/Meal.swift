//
//  Category.swift
//  RecipeApp
//
//  Created by Shivam on 3/28/24.
//

import Foundation

struct Meal {

    // MARK: Variables
    let id: String
    let name: String

    var imageURL = {
        return URL(string: "https://www.themealdb.com/images/ingredients/Lime-Small.png")
    }()

    // MARK: Setter
    mutating func setImageURL(_ url: URL?) {
        imageURL = url
    }
}
