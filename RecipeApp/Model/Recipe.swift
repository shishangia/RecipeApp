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

// MARK: Mock
extension Recipe {
    public static func mock() -> Recipe {
        return Recipe(id: "52772",
                   name: "Teriyaki Chicken Casserole",
                   instruction: "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
                   ingredients: [
                    Ingredient(ingredient: "soy sauce", measure: "3/4 cup"),
                    Ingredient(ingredient: "water", measure: "1/2 cup"),
                    Ingredient(ingredient: "brown sugar", measure: "1/4 cup"),
                    Ingredient(ingredient: "ground ginger", measure: "1/2 teaspoon"),
                    Ingredient(ingredient: "minced garlic", measure: "1/2 teaspoon"),
                    Ingredient(ingredient: "cornstarch", measure: "4 Tablespoons"),
                    Ingredient(ingredient: "chicken breasts", measure: "2"),
                    Ingredient(ingredient: "stir-fry vegetables", measure: "1 (12 oz.)"),
                    Ingredient(ingredient: "brown rice", measure: "3 cups")
                   ])
    }
}
