//
//  CategoriesViewModel.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import Foundation

class CategoriesViewModel {
    
//    // MARK: Variables
//    let category: Category

    // MARK: Init
//    init(_ category: Category) {
//        self.category = category
//    }

    func fetchDataFromAPI() {
//        var listOfCategories: [Category] = []
        if let apiUrl = URL(string: Constants.scheme + Constants.URL + Constants.API_PATH + "categories.php") {
            let session = URLSession.shared

            let task = session.dataTask(with: apiUrl) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
//                    if let jsonData = json as? Dictionary<String, AnyObject>, let categories = jsonData["categories"] as? [[String: AnyObject]] {
//                        for category in categories {
//                            if let id = category["idCategory"] as? Int,
//                                let name = category["strCategory"] as? String,
//                                let description = category["strCategoryDescription"] as? String,
//                                let imageURL = category["strCategoryThumb"] {
//                                var newCategory = Category(id: id, name: name, description: description)
//                                //                                newCategory.imageURL = URL(string: imageURL)
//                                listOfCategories.append(newCategory)
//                                print(imageURL)
//                            }
//                        }
//                        print(listOfCategories)
//                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
                
//                do {
//                    let categoriesResponse = try JSONDecoder().decode(Category.self, from: data)
//                    print(categoriesResponse)
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
            }

            task.resume()
        }
    }
}
