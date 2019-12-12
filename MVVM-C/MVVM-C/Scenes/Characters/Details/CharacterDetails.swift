//
//  CharacterDetails.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 10.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class CharacterDetails: UITableViewController {

    var viewModel: CharacterDetailsViewModelType!
    
    override func loadView() {
        super.loadView()
        
        configure()
        view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
    }
    
    // MARK: - Configuration
    
    private func configure() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(
            CharacterDetailsCell.classForCoder(),
            forCellReuseIdentifier: String(describing: CharacterDetailsCell.self)
        )
    }
    
}

// MARK: - Table view data source

extension CharacterDetails {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterDetailsCell.self), for: indexPath) as! CharacterDetailsCell
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
}
