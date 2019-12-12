//
//  UIImageView+KF.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 12.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImage(fromUrl urlString: String, withPlaceholer placeholder: UIImage?) {
        guard let url = URL(string: urlString) else {
            self.image = #imageLiteral(resourceName: "no_photo_placeholder")
            return
        }
        
        self.kf.indicatorType = .activity
        self.kf.indicator?.view.tintColor = #colorLiteral(red: 0.5176470588, green: 0.7647058824, blue: 0.09411764706, alpha: 1)
        
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [.transition(.flipFromRight(0.6))]
        ) { result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
}
