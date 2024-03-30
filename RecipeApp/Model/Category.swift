//
//  Category.swift
//  RecipeApp
//
//  Created by Shivam on 3/27/24.
//

import Foundation

struct Category: Decodable {
    let id: String
    let name: String

    var imageURL = {
        return URL(string: "https://www.themealdb.com/images/ingredients/Lime-Small.png")
    }()

    mutating func setImageURL(_ url: URL?) {
        imageURL = url
    }
}

extension Category {
    public static func mock() -> [Category] {
        return [
            Category(id: "1", name: "Beef"),
            Category(id: "2", name: "Chicken"),
            Category(id: "3", name: "Dessert")
        ]
    }
}