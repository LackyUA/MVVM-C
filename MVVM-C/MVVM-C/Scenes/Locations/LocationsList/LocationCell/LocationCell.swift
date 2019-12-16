//
//  LocationCell.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class LocationCell: UITableViewCell {

    // MARK: - Inits

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.3137254902, green: 0.2392156863, blue: 0.2588235294, alpha: 1)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        locationInfoStackView.addArrangedSubview(label)
        
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.5176470588, green: 0.7647058824, blue: 0.09411764706, alpha: 1)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        locationInfoStackView.addArrangedSubview(label)
        
        return label
    }()
    
    private lazy var dimensionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.5803921569, alpha: 1)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        locationInfoStackView.addArrangedSubview(label)
        
        return label
    }()
    
    private lazy var locationInfoStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
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
    
    // MARK: - Configuration
    
    private func initialConfigure() {
        locationInfoStackView.spacing = 4
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        
        clipsToBounds = true
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
    }
    
    func configure(with viewModel: LocationCellViewModelType) {
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimensionLabel.text = viewModel.dimension
    }

}
