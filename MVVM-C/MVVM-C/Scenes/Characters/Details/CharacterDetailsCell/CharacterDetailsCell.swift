//
//  CharacterDetailsCell.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 11.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class CharacterDetailsCell: UITableViewCell {

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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: characterPhotoView.topAnchor, constant: -24),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return label
    }()
    
    private lazy var characterPhotoView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: statusStackView.topAnchor, constant: -16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        ])
        
        return imageView
    }()
    
    private lazy var statusStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: speciesStackView.topAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return stackView
    }()
    
    private lazy var speciesStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: genderStackView.topAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return stackView
    }()
    
    private lazy var genderStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: currentLocationStackView.topAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return stackView
    }()
    
    private lazy var currentLocationStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        return stackView
    }()
    
    // MARK: - Configuration
    
    func configure(with viewModel: CharacterDetailsViewModelType) {
        nameLabel.text = viewModel.name
        characterPhotoView.loadImage(fromUrl: viewModel.photoPath, withPlaceholer: #imageLiteral(resourceName: "photo_placeholder"))
        
        statusStackView.configure(withDescription: "Status", and: viewModel.status)
        speciesStackView.configure(withDescription: "Species", and: viewModel.species)
        genderStackView.configure(withDescription: "Gender", and: viewModel.gender)
        currentLocationStackView.configure(withDescription: "Current location", and: viewModel.currentLocation)
    }
    
    private func initialConfigure() {
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
    }
    
}
