// MoovieDescriptionTableViewController.swift
// Copyright © Vera Malygina. All rights reserved.

import UIKit

final class MoovieDescriptionTableViewController: UITableViewController {
    // MARK: - Enum

    enum Cells {
        case poster
        case overview
    }

    // MARK: - Private Properties

    private var viewModel: DetailsViewModelProtocol?
    private var details: Description?
    private let cells: [Cells] = [.poster, .overview]
    private let identifires = [PosterTableViewCell.identifier, OverviewTableViewCell.identifier]

    // MARK: - Life Cycle View Controller

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel?.getDetailsMovie()
    }

    // MARK: - Override Methods

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        cells.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let detail = viewModel?.details else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifires[indexPath.row], for: indexPath)
        title = details?.title
        switch cells[indexPath.row] {
        case .poster:
            guard let posterCell = cell as? PosterTableViewCell else { return UITableViewCell() }
            posterCell.configureCell(details: detail, indexPath: indexPath)
        case .overview:
            guard let overviewCell = cell as? OverviewTableViewCell else { return UITableViewCell() }
            overviewCell.configureCell(details: detail, indexPath: indexPath)
        }
        return cell
    }

    // MARK: - Private Methods

    private func reloadTable() {
        viewModel?.reloadTable = { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func setupViewModel(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel
    }

    private func setupTableView() {
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = false
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.identifier)
        tableView.register(OverviewTableViewCell.self, forCellReuseIdentifier: OverviewTableViewCell.identifier)
    }
}
