//
//  CategoriesCollectionViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import UIKit

class CategoriesCollectionViewCell: BaseCollectionViewCell {

    static let identifier = "CategoriesCollectionViewCell"

    // MARK: Variables
    private(set) var category: Category!

    public func configure(with category: Category) {
        self.category = category
        configure(name: category.name, imageURL: category.imageURL)
    }
}
