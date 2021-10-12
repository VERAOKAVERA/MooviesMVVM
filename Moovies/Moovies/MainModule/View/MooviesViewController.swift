//
//  MooviesTableViewController.swift
//  Moovies
//
//  Created by Vera Zaitseva on 17.08.2021.
//

import UIKit

class MooviesViewController: UIViewController {
    // MARK: - Private Properties

    private var viewModel: MainViewModelProtocol?

    // MARK: - Private Visual Components

    private var segmentControl = UISegmentedControl(items: ["Популярные", "Топ-100", "Скоро"])
    internal var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.getMovie(url: "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU")
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
        switch segmentControl.selectedSegmentIndex {
        case 0:
            getPopularRequest()
        case 1:
            getTopRatedRequest()
        case 2:
            getUpcomingRequest()
        default:
            getPopularRequest()
        }
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
        let url =
        "https://api.themoviedb.org/3/movie/top_rated?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        viewModel?.getMovie(url: url)
        reloadTable()
    }

    private func getPopularRequest() {
        title = "Популярные фильмы"
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        viewModel?.getMovie(url: url)
        reloadTable()
    }

    private func getUpcomingRequest() {
        title = "Скоро на экранах"
        let url = "https://api.themoviedb.org/3/movie/upcoming?api_key=209be2942f86f39dd556564d2ad35c5c&language=ru-RU"
        viewModel?.getMovie(url: url)
        reloadTable()
    }
}

    // MARK: - Extension UITableViewDelegate

extension MooviesViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let id = viewModel?.results?[indexPath.row].id else { return }
        let descriptionVC = MoovieDescriptionTableViewController()
        descriptionVC.movieID = id
        navigationController?.pushViewController(descriptionVC, animated: true)
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
