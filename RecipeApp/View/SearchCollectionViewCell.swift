//
//  SearchCollectionViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {

    static let identifier = "SearchCollectionViewCell"

    // MARK: Variables
    private(set) var area: Area!

    public func configure(area: Area) {
        self.area = area
        configure(name: area.name, imageURL: area.imageURL)
    }
}
