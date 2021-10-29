// MooviesTableViewCell.swift
// Copyright © Vera Malygina. All rights reserved.

import UIKit

final class MooviesTableViewCell: UITableViewCell {
    // MARK: - Static Properties

    static let identifier = "mooviesTableViewCell"

    // MARK: - Private Properties

    private let imageAPIService = ImageAPIService()
    private let mainView = UIView()
    private let titleLabel = UILabel()
    private let posterImageView = UIImageView()
    private let overviewLabel = UILabel()
    private let releaseDatelabel = UILabel()
    private let ratingAverageLabel = UILabel()

    // MARK: - Table View Cell (*)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupView()
        setupPosterImageView()
        setupTitleLabel()
        setupreleaseDateLabel()
        setupOverviewLabel()
        setupAverage()
    }

    // MARK: - Internal Methods

    func configureCell(
        posterPath: String?,
        title: String?,
        overview: String?,
        releaseDate: String?,
        voteAverage: Float?
    ) {
        imageAPIService.getImage(imagePath: posterPath ?? "") { [weak self] result in
            switch result {
            case let .success(image):
                self?.posterImageView.image = image
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
        titleLabel.text = title
        overviewLabel.text = overview
        releaseDatelabel.text = convertDateFormat(inputDate: releaseDate ?? "")
        ratingAverageLabel.text = "\(String(describing: voteAverage))"
    }

    // MARK: Private Methods

    private func convertDateFormat(inputDate: String) -> String {
        let oldDateFormatter = DateFormatter()
        oldDateFormatter.dateFormat = "yyyy-MM-dd"

        guard let oldDate = oldDateFormatter.date(from: inputDate) else { return String() }

        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM yyyy"
        convertDateFormatter.locale = NSLocale(localeIdentifier: "ru_RU_POSIX") as Locale

        return convertDateFormatter.string(from: oldDate)
    }

    private func setupAverage() {
        mainView.addSubview(ratingAverageLabel)
        ratingAverageLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingAverageLabel.backgroundColor = .systemPink
        ratingAverageLabel.textAlignment = .center
        ratingAverageLabel.clipsToBounds = true
        ratingAverageLabel.layer.cornerRadius = 5
        ratingAverageLabel.textColor = .white
        NSLayoutConstraint.activate([
            ratingAverageLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            ratingAverageLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 5),
            ratingAverageLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5),
            ratingAverageLabel.widthAnchor.constraint(
                equalTo: ratingAverageLabel.heightAnchor,
                multiplier: 1.5
            ),
        ])
    }

    private func setupreleaseDateLabel() {
        mainView.addSubview(releaseDatelabel)
        releaseDatelabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDatelabel.textAlignment = .right
        releaseDatelabel.font = UIFont.boldSystemFont(ofSize: 17)
        NSLayoutConstraint.activate([
            releaseDatelabel.heightAnchor.constraint(equalToConstant: 25),
            releaseDatelabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            releaseDatelabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            releaseDatelabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5),
        ])
    }

    private func setupView() {
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            mainView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            mainView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            mainView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            mainView.heightAnchor.constraint(equalToConstant: 200),
        ])
        mainView.layer.cornerRadius = 9
        mainView.contentMode = .scaleAspectFill
        mainView.layer.borderColor = UIColor.systemPink.cgColor
        mainView.layer.borderWidth = 2
        mainView.clipsToBounds = true
    }

    private func setupTitleLabel() {
        mainView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

    private func setupOverviewLabel() {
        mainView.addSubview(overviewLabel)
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.textAlignment = .center
        overviewLabel.numberOfLines = 0
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            overviewLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            overviewLabel.bottomAnchor.constraint(equalTo: releaseDatelabel.topAnchor, constant: -5),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 5),
        ])
    }

    private func setupPosterImageView() {
        mainView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleToFill
        if posterImageView.image == nil {
            posterImageView.tintColor = .gray
            posterImageView.image = UIImage(systemName: "heart.fill")
        }
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.7),
        ])
    }
}
