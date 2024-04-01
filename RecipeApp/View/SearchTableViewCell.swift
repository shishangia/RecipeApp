//
//  SearchTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/31/24.
//

import UIKit

class SearchTableViewCell: BaseTableViewCell {

    static let identifier = "SearchTableViewCell"

    // MARK: Variables
    private(set) var category: Category!

    public func configure(name: String) {
        self.cellName.text = name
    }
}
