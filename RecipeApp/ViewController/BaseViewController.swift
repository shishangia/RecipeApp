//
//  BaseViewController.swift
//  RecipeApp
//
//  Created by Shivam on 3/30/24.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Variables
    public var data: [Any] = []

    // MARK: UI Componenets
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupUI()
    }

    // MARK: UI Setup
    func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(BaseCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "BaseCollectionViewCell")
        self.view.addSubview(self.collectionView)
    }

    public func setupUI() {
        self.view.backgroundColor = .systemBackground

        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor, constant: -10),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
    }
}

// MARK: UICollectionView Delegates
extension BaseViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BaseCollectionViewCell", for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 10 * 3
        let availableWidth = collectionView.frame.width - CGFloat(paddingSpace)
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: widthPerItem + 25)
    }
}
