//
//  CharacterDetailsCell.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 11.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class CharacterDetailsCell: UITableViewCell {
    
    // MARK: - Properties
    
    var regularConstraints: [NSLayoutConstraint] = []
    var compactConstraints: [NSLayoutConstraint] = []

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
        
        return label
    }()
    
    private lazy var characterPhotoView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        return imageView
    }()
    
    private lazy var statusStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        return stackView
    }()
    
    private lazy var speciesStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        return stackView
    }()
    
    private lazy var genderStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        return stackView
    }()
    
    private lazy var currentLocationStackView: DetailStackView = {
        let stackView = DetailStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
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
        
        configureConstraints()
        activateCurrentConstraints()
    }
    
    private func configureConstraints() {
        // Name label constraints
        regularConstraints.append(contentsOf: [
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            nameLabel.bottomAnchor.constraint(equalTo: characterPhotoView.topAnchor, constant: -24),
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        compactConstraints.append(contentsOf: [
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: characterPhotoView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // Photo view constraints
        regularConstraints.append(contentsOf: [
            characterPhotoView.centerXAnchor.constraint(equalTo: centerXAnchor),
            characterPhotoView.bottomAnchor.constraint(equalTo: statusStackView.topAnchor, constant: -16),
            characterPhotoView.heightAnchor.constraint(equalTo: characterPhotoView.widthAnchor, multiplier: 1.0),
            characterPhotoView.heightAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 48)
        ])
        
        compactConstraints.append(contentsOf: [
            characterPhotoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            characterPhotoView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            characterPhotoView.heightAnchor.constraint(equalTo: characterPhotoView.widthAnchor, multiplier: 1.0),
            characterPhotoView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            characterPhotoView.heightAnchor.constraint(equalToConstant: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - 48)
        ])
        
        // Status stack view constraints
        regularConstraints.append(contentsOf: [
            statusStackView.bottomAnchor.constraint(equalTo: speciesStackView.topAnchor, constant: -24),
            statusStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            statusStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        compactConstraints.append(contentsOf: [
            statusStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 36),
            statusStackView.leadingAnchor.constraint(equalTo: characterPhotoView.trailingAnchor, constant: 16),
            statusStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // Species stack view constraints
        regularConstraints.append(contentsOf: [
            speciesStackView.bottomAnchor.constraint(equalTo: genderStackView.topAnchor, constant: -24),
            speciesStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            speciesStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        compactConstraints.append(contentsOf: [
            speciesStackView.topAnchor.constraint(equalTo: statusStackView.bottomAnchor, constant: 24),
            speciesStackView.leadingAnchor.constraint(equalTo: characterPhotoView.trailingAnchor, constant: 16),
            speciesStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // Gender stack view constraints
        regularConstraints.append(contentsOf: [
            genderStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            genderStackView.bottomAnchor.constraint(equalTo: currentLocationStackView.topAnchor, constant: -24),
            genderStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        compactConstraints.append(contentsOf: [
            genderStackView.topAnchor.constraint(equalTo: speciesStackView.bottomAnchor, constant: 24),
            genderStackView.leadingAnchor.constraint(equalTo: characterPhotoView.trailingAnchor, constant: 16),
            genderStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        // Current location stack view constraints
        regularConstraints.append(contentsOf: [
            currentLocationStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            currentLocationStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            currentLocationStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        compactConstraints.append(contentsOf: [
            currentLocationStackView.topAnchor.constraint(equalTo: genderStackView.bottomAnchor, constant: 24),
            currentLocationStackView.leadingAnchor.constraint(equalTo: characterPhotoView.trailingAnchor, constant: 16),
            currentLocationStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func activateCurrentConstraints() {
        NSLayoutConstraint.deactivate(self.compactConstraints + self.regularConstraints)

        if self.traitCollection.verticalSizeClass == .regular {
            NSLayoutConstraint.activate(self.regularConstraints)
        }
        else {
            NSLayoutConstraint.activate(self.compactConstraints)
        }
    }
    
    private func initialConfigure() {
        backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
    }

    // MARK: - trait collections

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        self.activateCurrentConstraints()
    }
    
}
