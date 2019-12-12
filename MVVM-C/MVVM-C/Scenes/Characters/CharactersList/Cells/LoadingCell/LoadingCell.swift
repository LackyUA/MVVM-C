//
//  LoadingCell.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 11.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class LoadingCell: UITableViewCell {

    // MARK: - Inits
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        
        activityIndicator.color = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
        activityIndicator.tintColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            activityIndicator.heightAnchor.constraint(equalToConstant: 24),
            activityIndicator.widthAnchor.constraint(equalToConstant: 24),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        return activityIndicator
    }()
    
    // MARK: - Life cycle
    
    override func prepareForReuse() {
        activityIndicator.startAnimating()
    }

    // MARK: - Configure
    
    private func initialConfiguration() {
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        clipsToBounds = true
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: 1000, bottom: 0, right: 0)
        
        activityIndicator.startAnimating()
    }
    
}
