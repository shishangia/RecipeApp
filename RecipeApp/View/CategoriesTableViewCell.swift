//
//  CategoriesTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/27/24.
//

import UIKit

class CategoriesTableViewCell: BaseTableViewCell {

    static let identifier = "CategoriesTableViewCell"

    // MARK: Variables
    private(set) var category: Category!

    public func configure(with category: Category) {
        self.category = category
        configure(name: category.name, imageURL: category.imageURL)
    }
}
