//
//  RecipeAppTests.swift
//  RecipeAppTests
//
//  Created by Shivam on 3/26/24.
//

import XCTest
@testable import RecipeApp

final class HomeViewControllerUnitTests: XCTestCase {

    var homeViewController: HomeViewController!

    override func setUp() {
        super.setUp()
        homeViewController = HomeViewController()
        homeViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        homeViewController = nil
        super.tearDown()
    }

    func testTitle() {
        XCTAssertEqual(homeViewController.navigationItem.title, "Home")
    }

    func testCollectionView() {
        XCTAssertNotNil(homeViewController.collectionView)
    }

    func testCollectionViewCell() {
        let cell = homeViewController.collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(cell)
        XCTAssertTrue(cell is CategoriesCollectionViewCell)
    }
}
