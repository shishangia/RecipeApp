//
//  MealsCollectionViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import UIKit

class MealsCollectionViewCell: BaseCollectionViewCell {
    
    static let identifier = "MealsCollectionViewCell"

    // MARK: Variables
    private(set) var meal: Meal!

    public func configure(with meal: Meal) {
        self.meal = meal
        configure(name: meal.name, imageURL: meal.imageURL)
    }
}
