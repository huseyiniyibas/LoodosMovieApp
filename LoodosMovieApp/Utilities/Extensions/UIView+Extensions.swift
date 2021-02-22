//
//  UIView+Extensions.swift
//  LoodosMovieApp
//
//  Created by Hüseyin on 17.02.2021.
//

import UIKit

extension UIView {
    func addRedBorder() {
        self.layer.borderColor = UIColor(red: 0.945, green: 0.341, blue: 0.267, alpha: 1).cgColor
        self.layer.borderWidth = 2
    }

    func addGreenBorder() {
        self.layer.borderColor = UIColor(red: 0.514, green: 0.749, blue: 0.31, alpha: 1).cgColor
        self.layer.borderWidth = 2
    }

    func addGrayBorder() {
        self.layer.borderColor = UIColor(red: 0.51, green: 0.529, blue: 0.584, alpha: 0.5).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
    }

    func removeBorder() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 0
    }
}
