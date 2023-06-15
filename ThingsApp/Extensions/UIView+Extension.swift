//
//  UIView+Extension.swift
//  ThingsApp
//
//  Created by aleksandar.aleksic on 9.6.23..
//

import UIKit

extension UIView {

    func addAnimationWiggle(){
        let wiggle = CASpringAnimation(keyPath: "transform.rotation")
        wiggle.duration = 0.80
        wiggle.fromValue = -0.60
        wiggle.toValue = -0.5
        wiggle.autoreverses = true
        wiggle.repeatCount = Float.greatestFiniteMagnitude
        wiggle.initialVelocity = 0.98
        wiggle.damping = 10
        layer.add(wiggle, forKey: "wiggle")
    }

    func addAnimationRotatation(repeatCount: Float = Float.greatestFiniteMagnitude) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = repeatCount
        layer.add(rotation, forKey: "rotationAnimation")
    }
}
