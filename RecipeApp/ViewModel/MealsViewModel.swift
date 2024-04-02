//
//  MealsViewModel.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import Foundation

class MealsViewModel {

    // MARK: Variables
    public var meals: [Meal] = []
    private let fetchType: APICalls.FetchType

    // MARK: Lifecycle
    init(fetchType: APICalls.FetchType) {
        self.fetchType = fetchType
    }

    // MARK: Fetch from API
    public func fetchData(completion: @escaping () -> Void) {
        APICalls.fetchMeals(fetchType: self.fetchType) { [weak self] meals in
            guard let self = self else { return }

            if let meals = meals {
                self.meals = meals
            } else {
                print("Failed to fetch meals")
            }
            completion()
        }
    }

    public func setupNavigationTitle() -> String {
        switch fetchType {
        case .byCategory(let categoryName):
            return categoryName
        case .bySearch(let searchKey):
            return "Search Results for \(searchKey)"
        case .byArea(let area):
            return "\(area) meals"
        }
    }
}
