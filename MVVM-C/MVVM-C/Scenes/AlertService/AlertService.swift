//
//  AlertService.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class AlertService {
    
    static func showAlert(vc: UIViewController, title: String?, message: String?, completionHandler:(() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0.5176470588, green: 0.7647058824, blue: 0.09411764706, alpha: 1)

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler?()
        }

        alert.addAction(okAction)

        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
    
}
