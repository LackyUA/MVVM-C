//
//  EpisodesList.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class EpisodesList: UIViewController {

    // MARK: - Properties
    
    var viewModel: ListViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    // MARK: - UI components
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        
        refreshControl.tintColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
        
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        
        tableView.register(
            EpisodeCell.classForCoder(),
            forCellReuseIdentifier: String(describing: EpisodeCell.self)
        )
        tableView.register(
            LoadingCell.classForCoder(),
            forCellReuseIdentifier: String(describing: LoadingCell.self)
        )
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0)
        ])
        
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        navigationItem.title = "Episodes"
        
        configureRefreshControl()
        viewModel.start()
    }
    
    func configureRefreshControl() {
        tableView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
        refreshControl.beginRefreshing()
    }

    // MARK: - Actions
    
    @objc private func reloadData() {
        viewModel.reloadData()
    }

}

// MARK: - Table view delegate

extension EpisodesList: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModel.didSelect(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

// MARK: - Table view data source

extension EpisodesList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.numberOfCells - 1, viewModel.shouldLoadMore {
            return tableView.dequeueReusableCell(withIdentifier: String(describing: LoadingCell.self), for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeCell.self), for: indexPath) as! EpisodeCell
        
        if let viewModel = viewModel.viewModelFor(row: indexPath.row) as? EpisodeCellViewModel {
            cell.configure(with: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfCells - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.viewModel.loadMore()
            }
        }
    }
    
}

// MARK: - View model delegate

extension EpisodesList: ListViewModelDelegate {
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func updateLoadingStatus(_ isLoading: Bool) {
        if !isLoading {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
}
