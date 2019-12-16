//
//  EpisodeCellStackView.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 14.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class EpisodeCellStackView: UIStackView {

    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        spacing = 8
        axis = .vertical
        alignment = .fill
        distribution = .fillProportionally
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.3137254902, green: 0.2392156863, blue: 0.2588235294, alpha: 1)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        addArrangedSubview(label)
        
        return label
    }()
    
    private lazy var releseDateLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.5725490196, green: 0.6784313725, blue: 0.5803921569, alpha: 1)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
        
        addArrangedSubview(label)
        
        return label
    }()
    
    // MARK: - Configuration
    
    func configure(withName name: String, andReleaseDate date: String) {
        nameLabel.text = name
        releseDateLabel.text = "Released: \(date)"
    }

}
