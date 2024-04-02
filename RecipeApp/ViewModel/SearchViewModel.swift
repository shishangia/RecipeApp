//
//  SearchViewModel.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import Foundation

class SearchViewModel {

    // MARK: Variables
    public var areas: [Area] = []

    // MARK: Fetch from API
    public func fetchData(completion: @escaping () -> Void) {
        APICalls.fetchAreas { [weak self] areas in
            guard let self = self else { return }

            if let areas = areas {
                self.areas = areas
            } else {
                print("Failed to fetch areas")
            }
            completion()
        }
    }
}
