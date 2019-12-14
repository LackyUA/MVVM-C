//
//  EpisodeCell.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class EpisodeCell: UITableViewCell {
    
    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var episodeStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .top
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return stackView
    }()
    
    private lazy var detailsStackView: EpisodeCellStackView = {
        let stackView = EpisodeCellStackView()
        
        episodeStackView.addArrangedSubview(stackView)
        
        return stackView
    }()
    
    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.7647058824, blue: 0.09411764706, alpha: 1)
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        episodeStackView.addArrangedSubview(label)
        
        return label
    }()
    
    // MARK: - Configuration
    
    private func initialConfigure() {
        episodeStackView.spacing = 8
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        
        clipsToBounds = true
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
    }
    
    func configure(with viewModel: EpisodeCellViewModelType) {
        detailsStackView.configure(withName: viewModel.name, andReleaseDate: viewModel.releaseDate)
        episodeLabel.text = viewModel.abbreviation
    }
    
}
