//
//  APICalls.swift
//  RecipeApp
//
//  Created by Shivam on 3/29/24.
//

import Foundation

class APICalls {
    private static func fetchData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
        }
        task.resume()
    }

    private static func handleResponse<T>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (T?) -> Void, parse: (Data) -> T?) {
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

        guard let parsedData = parse(data) else {
            print("Failed to parse data.")
            completion(nil)
            return
        }

        completion(parsedData)
    }

    public static func fetchRecipe(recipeID: String,
                                   completion: @escaping (Recipe?) -> Void) {
        guard let apiURL = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        fetchData(from: apiURL) { data, response, error in
            handleResponse(data: data, response: response, error: error, completion: completion) { data in
                guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let meals = jsonDictionary["meals"] as? [[String: Any]],
                      let meal = meals.first else {
                    print("Failed to decode JSON data.")
                    return nil
                }
                let id = meal["idMeal"] as? String ?? ""
                let name = meal["strMeal"] as? String ?? ""
                let instruction = meal["strInstructions"] as? String ?? ""
                let imageURL = meal["strMealThumb"] as? String ?? ""
                var ingredients: [Ingredient] = []
                for i in 1...20 {
                    if let ingredient = meal["strIngredient\(i)"] as? String,
                       let measure = meal["strMeasure\(i)"] as? String,
                       !ingredient.isEmpty && !measure.isEmpty {
                        ingredients.append(Ingredient(ingredient: ingredient, measure: measure))
                    }
                }
                var recipe = Recipe(id: id, name: name, instruction: instruction, ingredients: ingredients)
                recipe.setImageURL(URL(string: imageURL))
                return recipe
            }
        }
    }

    public static func fetchMeals(mealCategory: String,
                                  completion: @escaping ([Meal]?) -> Void) {
        guard let apiURL = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(mealCategory)") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        fetchData(from: apiURL) { data, response, error in
            handleResponse(data: data, response: response, error: error, completion: completion) { data in
                guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let meals = jsonDictionary["meals"] as? [[String: Any]] else {
                    print("Failed to decode JSON data.")
                    return nil
                }
                var fetchedMeals: [Meal] = []
                for meal in meals {
                    let id = meal["idMeal"] as? String ?? ""
                    let name = meal["strMeal"] as? String ?? ""
                    let imageURL = meal["strMealThumb"] as? String ?? ""
                    var newMeal = Meal(id: id, name: name)
                    newMeal.setImageURL(URL(string: imageURL))
                    fetchedMeals.append(newMeal)
                }
                return fetchedMeals
            }
        }
    }

    public static func fetchCategories(completion: @escaping ([Category]?) -> Void) {
        guard let apiURL = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            print("Invalid URL")
            completion(nil)
            return
        }

        fetchData(from: apiURL) { data, response, error in
            handleResponse(data: data, response: response, error: error, completion: completion) { data in
                guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let categories = jsonDictionary["categories"] as? [[String: Any]] else {
                    print("Failed to decode JSON data.")
                    return nil
                }
                var fetchedCategories: [Category] = []
                for category in categories {
                    let id = category["idCategory"] as? String ?? ""
                    let name = category["strCategory"] as? String ?? ""
                    let imageURL = category["strCategoryThumb"] as? String ?? ""
                    var newCategory = Category(id: id, name: name)
                    newCategory.setImageURL(URL(string: imageURL))
                    fetchedCategories.append(newCategory)
                }
                return fetchedCategories
            }
        }
    }
}
