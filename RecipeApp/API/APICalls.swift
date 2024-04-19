//
//  APICalls.swift
//  RecipeApp
//
//  Created by Shivam on 3/29/24.
//

import Foundation

class APICalls {

    // MARK: Constants
    static let APIBaseURL = "https://www.themealdb.com/api/json/v1/1/"

    // MARK: Enum
    public enum FetchType {
        case byCategory(String)
        case bySearch(String)
        case byArea(String)
    }

    // MARK: Public functions
    public static func fetchRecipe(recipeID: String,
                                   completion: @escaping (Recipe?) -> Void) {
        var components = URLComponents(string: APIBaseURL + "lookup.php")
        components?.queryItems = [URLQueryItem(name: "i", value: recipeID)]
        guard let apiURL = components?.url else {
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
                       !ingredient.trimmingCharacters(in: .whitespaces).isEmpty && !measure.trimmingCharacters(in: .whitespaces).isEmpty {
                        ingredients.append(Ingredient(ingredient: ingredient.capitalized, measure: measure))
                    }
                }
                var recipe = Recipe(id: id, name: name, instruction: instruction, ingredients: ingredients)
                recipe.setImageURL(URL(string: imageURL))
                return recipe
            }
        }
    }

    public static func fetchMeals(fetchType: FetchType,
                                  completion: @escaping ([Meal]?) -> Void) {
        var path = ""
        var queryItems: [URLQueryItem] = []

        switch fetchType {
        case .byCategory(let mealCategory):
            path = "/filter.php"
            queryItems.append(URLQueryItem(name: "c", value: mealCategory))
        case .bySearch(let searchKey):
            path = "/search.php"
            queryItems.append(URLQueryItem(name: "s", value: searchKey))
        case .byArea(let area):
            path = "/filter.php"
            queryItems.append(URLQueryItem(name: "a", value: area))
        }

        var components = URLComponents(string: APIBaseURL + path)
        components?.queryItems = queryItems

        guard let apiURL = components?.url else {
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
        guard let apiURL = URL(string: APIBaseURL + "/categories.php") else {
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

    public static func fetchAreas(completion: @escaping ([Area]?) -> Void) {
        var components = URLComponents(string: APIBaseURL + "list.php")
        components?.queryItems = [URLQueryItem(name: "a", value: "list")]
        guard let apiURL = components?.url else {
            print("Invalid URL")
            completion(nil)
            return
        }

        fetchData(from: apiURL) { data, response, error in
            handleResponse(data: data, response: response, error: error, completion: completion) { data in
                guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let areas = jsonDictionary["meals"] as? [[String: Any]] else {
                    print("Failed to decode JSON data.")
                    return nil
                }
                var fetchedAreas: [Area] = []
                for area in areas {
                    let name = area["strArea"] as? String ?? ""
                    let newArea = Area(name: name)
                    fetchedAreas.append(newArea)
                }
                return fetchedAreas
            }
        }
    }

    // MARK: Helper functions
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
}
