//
//  ViewX.swift
//  Tweetrian
//
//  Created by Abdelrahman Shehab on 22/8/2020.
//

import Foundation
import UIKit


extension UIView {

    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setTripleGradientBackground(colorOne: UIColor, colorTwo: UIColor,colorThree: UIColor) {

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor, colorThree.cgColor]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func setShadow() {

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.65
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = false
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true

    }

    func setShadowImage()
    {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 1
    }

}
