// PosterTableViewCell.swift
// Copyright © Vera Malygina. All rights reserved.

import UIKit

final class PosterTableViewCell: UITableViewCell {
    // MARK: - Static Properties

    static let identifier = "PosterTableViewCell"

    // MARK: - Private Visual Components

    private let posterImageView = UIImageView()

    // MARK: - Internal Properties

    let imageAPIService = ImageAPIService()

    // MARK: - Set Selected

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupImageView()
    }

    // MARK: - Internal Methods

    func configureCell(details: Description, indexPath _: IndexPath) {
        imageAPIService.getImage(imagePath: details.posterPath ?? "") { [weak self] result in
            switch result {
            case let .success(image):
                self?.posterImageView.image = image
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }

    // MARK: - Private Methods

    private func setupImageView() {
        addSubview(posterImageView)
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            posterImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            posterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            posterImageView.heightAnchor.constraint(equalToConstant: 400),
            posterImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
        ])
    }
}
