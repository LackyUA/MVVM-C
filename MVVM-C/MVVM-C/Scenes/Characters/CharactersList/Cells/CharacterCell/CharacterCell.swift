//
//  CharacterCell.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 10.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initialConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.3137254902, green: 0.2392156863, blue: 0.2588235294, alpha: 1)
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return label
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.5803921569, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.tintColor = #colorLiteral(red: 0.5176470588, green: 0.7647058824, blue: 0.09411764706, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        stackView.distribution = .fill
        stackView.addArrangedSubview(genderLabel)
        stackView.addArrangedSubview(statusImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
        return stackView
    }()
    
    // MARK: - Configure
    
    func configure(with viewModel: CharacterCellViewModelType) {
        nameLabel.text = viewModel.name
        genderLabel.text = viewModel.gender
        
        switch viewModel.characterStatus {
        case .alive:
            statusImageView.image = #imageLiteral(resourceName: "alive")
            
        case .dead:
            statusImageView.image = #imageLiteral(resourceName: "dead")
            
        case .unknown:
            statusImageView.image = #imageLiteral(resourceName: "unknown")
        }
    }
    
    private func initialConfiguration() {
        stackView.spacing = 8
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        
        clipsToBounds = true
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
    }

}
