//
//  MealsTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/30/24.
//

import UIKit

class MealsTableViewCell: BaseTableViewCell {
    
    static let identifier = "MealsTableViewCell"

    // MARK: Variables
    private(set) var meal: Meal!

    public func configure(with meal: Meal) {
        self.meal = meal
        configure(name: meal.name, imageURL: meal.imageURL)
    }
}
