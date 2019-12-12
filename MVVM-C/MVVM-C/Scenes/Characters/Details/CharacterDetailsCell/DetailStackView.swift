//
//  DetailStackView.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class DetailStackView: UIStackView {
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        alignment = .top
        axis = .horizontal
        distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI components
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.3137254902, green: 0.2392156863, blue: 0.2588235294, alpha: 1)
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        addArrangedSubview(label)
        
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = #colorLiteral(red: 0.4549019608, green: 0.5450980392, blue: 0.4588235294, alpha: 1)
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        
        addArrangedSubview(label)
        
        return label
    }()
    
    // MARK: - Configuration
    
    func configure(withDescription description: String, and value: String) {
        descriptionLabel.text = description
        valueLabel.text = value
    }

}
