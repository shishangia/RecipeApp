//
//  Category.swift
//  RecipeApp
//
//  Created by Shivam on 3/28/24.
//

import Foundation

struct Meal: Decodable {
    let id: String
    let name: String

    var imageURL = {
        return URL(string: "https://www.themealdb.com/images/ingredients/Lime-Small.png")
    }()

    mutating func setImageURL(_ url: URL?) {
        imageURL = url
    }
}

extension Meal {
    public static func mock() -> [Meal] {
        return [
            Meal(id: "52959", name: "Baked salmon with fennel & tomatoes"),
            Meal(id: "52819", name: "Cajun spiced fish tacos"),
            Meal(id: "52944", name: "Escovitch Fish"),
        ]
    }
}
