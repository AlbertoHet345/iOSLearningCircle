//
//  UIImageView+CircularImage.swift
//  iOSLearningCircle
//
//  Created by Alberto Garcia on 06/06/23.
//

import UIKit

extension UIImageView {
    func setCircularImageView() {
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
}
