//
//  BaseTableViewCell.swift
//  RecipeApp
//
//  Created by Shivam on 3/30/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    // MARK: UI Componenets
    public let cellImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "questionmark")
        image.contentMode = .scaleAspectFit
        return image
    }()

    public let cellName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Error"
        return label
    }()

    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(name: String, imageURL: URL?) {
        self.cellName.text = name

        guard let url = imageURL else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            DispatchQueue.main.async {
                self.cellImage.image = UIImage(data: data)
            }
        }
        task.resume()
    }

    // MARK: UI Setup
    private func setupUI() {
        self.addSubview(cellName)
        self.addSubview(cellImage)

        cellName.translatesAutoresizingMaskIntoConstraints = false
        cellImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellImage.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            cellImage.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            cellImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),

            cellName.leadingAnchor.constraint(equalTo: cellImage.trailingAnchor, constant: 16),
            cellName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellName.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
