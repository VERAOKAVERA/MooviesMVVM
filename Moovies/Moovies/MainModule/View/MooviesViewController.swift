// MooviesViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MooviesViewController: UIViewController {
    // MARK: - Private Properties

    private var viewModel: MainViewModelProtocol?

    // MARK: - Private Visual Components

    private var segmentControl = UISegmentedControl(items: ["Популярные", "Топ-100", "Скоро"])
    internal var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?
            .getMovie(type: .popular)
        setupTableView()
        setupSegmentControl()
        reloadTable()
    }

    // MARK: - Internal Methods

    func setupViewModel(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
    }

    // MARK: - Private Methods

    private func setupSegmentControl() {
        view.addSubview(segmentControl)
        segmentControl.backgroundColor = .systemPink
        segmentControl.selectedSegmentIndex = 0
        segmentControl.frame = CGRect(x: 10, y: 20, width: 390, height: 50)
        segmentControl.addTarget(self, action: #selector(segmentedValueChanged), for: .valueChanged)
    }

    @objc func segmentedValueChanged(_: UISegmentedControl!) {
        viewModel?.setupSwitchSegmentControl(segmentControl: segmentControl)
    }

    private func setupTableView() {
        title = "Топ-100"
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backButtonTitle = ""
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MooviesTableViewCell.self, forCellReuseIdentifier: MooviesTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func reloadTable() {
        viewModel?.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    private func getTopRatedRequest() {
        title = "Топ-100 за все время"
        viewModel?.getMovie(type: .topRated)
        reloadTable()
    }

    private func getPopularRequest() {
        title = "Популярные фильмы"
        viewModel?.getMovie(type: .popular)
        reloadTable()
    }

    private func getUpcomingRequest() {
        title = "Скоро на экранах"
        viewModel?.getMovie(type: .upcoming)
        reloadTable()
    }
}

// MARK: - Extension UITableViewDelegate

extension MooviesViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel?.results?[indexPath.row].id else { return }
//        let descriptionVC = MoovieDescriptionTableViewController()
//        descriptionVC.movieID = id
//        navigationController?.pushViewController(descriptionVC, animated: true)
        let detailsTableViewController = MoovieDescriptionTableViewController()
        let movieAPIService = MovieAPIService()
        let detailsViewModel = DetailsViewModel(movieAPIService: movieAPIService, movieID: id)
        detailsTableViewController.setupViewModel(viewModel: detailsViewModel)
        navigationController?.pushViewController(detailsTableViewController, animated: true)
    }
}

// MARK: - Extension UITableViewDataSource

extension MooviesViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard let countFilms = viewModel?.results?.count else { return Int() }
        return countFilms
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "mooviesTableViewCell",
            for: indexPath
        ) as? MooviesTableViewCell else { return UITableViewCell() }
        cell.configureCell(
            posterPath: viewModel?.results?[indexPath.row].posterPath,
            title: viewModel?.results?[indexPath.row].title,
            overview: viewModel?.results?[indexPath.row].overview,
            releaseDate: viewModel?.results?[indexPath.row].releaseDate,
            voteAverage: viewModel?.results?[indexPath.row].voteAverage
        )
        cell.selectionStyle = .none
        return cell
    }
}
