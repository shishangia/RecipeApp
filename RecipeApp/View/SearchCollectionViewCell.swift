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
    private(set) var category: Category!

    public func configure(name: String) {
        self.cellLabel.text = name
    }
}
