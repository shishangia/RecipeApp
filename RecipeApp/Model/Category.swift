//
//  Category.swift
//  RecipeApp
//
//  Created by Shivam on 3/27/24.
//

import Foundation

struct Category: Decodable {
    let id: Int
    let name: String
    let description: String
    
    var imageURL: URL? {
        return URL(string: "https://www.themealdb.com/images/ingredients/Lime-Small.png")
    }
}

extension Category {
    public static func mock() -> [Category] {
        return [
            Category(id: 1, name: "Rajma Chawal", description: "Lorem Ipsum"),
            Category(id: 2, name: "Pizza", description: "Lorem Ipsum"),
            Category(id: 3, name: "Cake", description: "Lorem Ipsum"),
        ]
    }
}
