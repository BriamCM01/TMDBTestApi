//
//  UIView+Extension.swift
//  MyMoviesD
//
//  Created by Briam Cano on 04/08/24.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
