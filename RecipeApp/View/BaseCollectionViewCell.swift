//
//  BaseCollectionViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 4/1/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    // MARK: UI Componenets
    public let cellImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark.circle")
        image.contentMode = .scaleAspectFit
        image.tintColor = UIColor(red: 244/255, green: 244/255, blue: 245/255, alpha: 1)
        image.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    public let cellLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 0
        label.text = "Error"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UI Setup
    private func setupUI() {
        self.addSubview(self.cellLabel)
        self.addSubview(self.cellImage)

        NSLayoutConstraint.activate([
            self.cellImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.cellImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.cellImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.cellImage.heightAnchor.constraint(equalTo: self.widthAnchor),

            self.cellLabel.topAnchor.constraint(equalTo: self.cellImage.bottomAnchor),
            self.cellLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.cellLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.cellLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4)
        ])

        self.cellImage.layer.cornerRadius = 20
        self.cellImage.clipsToBounds = true
    }

    // MARK: Public methods
    public func configure(name: String, imageURL: URL?) {
        self.cellLabel.text = name

        guard let url = imageURL else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }

            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            DispatchQueue.main.async {
                self.cellImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.cellImage.image = UIImage(data: data)
            }
        }
        task.resume()
    }
}
