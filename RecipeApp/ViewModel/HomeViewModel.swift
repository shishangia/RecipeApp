//
//  HomeViewModel.swift
//  RecipeApp
//
//  Created by Shivam on 3/26/24.
//

import Foundation

class HomeViewModel {

    // MARK: Variables
    public var categories: [Category] = []

    // MARK: Fetch from API
    public func fetchData(completion: @escaping () -> Void) {
        APICalls.fetchCategories { [weak self] categories in
            guard let self = self else { return }

            if let categories = categories {
                self.categories = categories
            } else {
                print("Failed to fetch categories")
            }
            completion()
        }
    }
}
