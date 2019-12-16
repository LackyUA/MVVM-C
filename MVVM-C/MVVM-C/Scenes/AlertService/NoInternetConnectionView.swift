//
//  NoInternetConnectionView.swift
//  MVVM-C
//
//  Created by Dmytro Dobrovolskyy on 16.12.2019.
//  Copyright © 2019 Dmytro Dobrovolskyy. All rights reserved.
//

import UIKit

final class NoInternetConnectionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        let label = UILabel(frame: CGRect(x: 0, y: 12, width: UIScreen.main.bounds.width, height: 20))
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)

        label.text = "No internet."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = #colorLiteral(red: 0.9607843137, green: 0.9843137255, blue: 0.937254902, alpha: 1)
        label.textAlignment = .center

        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        backgroundColor = #colorLiteral(red: 0.3137254902, green: 0.2392156863, blue: 0.2588235294, alpha: 1)
        accessibilityIdentifier = "no_internet"

        addSubview(blurEffectView)
        addSubview(label)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
