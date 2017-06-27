//
//  UIView+Blur.swift
//  Blur
//
//  Created by Roman Sorochak <roman.sorochak@gmail.com> on 6/27/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyBlurEffect(style: UIBlurEffectStyle,
                         enableVibrancy: Bool,
                         blurAlpha: CGFloat) {
        self.backgroundColor = UIColor.clear
        
        let blurEffectView: UIVisualEffectView = {
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
            
            guard enableVibrancy else {
                return blurEffectView
            }
            
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)
            
            return blurEffectView
        }()
        
        blurEffectView.alpha = blurAlpha
        
        self.insertSubview(blurEffectView, at: 0)
        
        func addAlignConstraintToSuperview(attribute: NSLayoutAttribute) {
            addConstraint(
                NSLayoutConstraint(
                    item: blurEffectView,
                    attribute: attribute,
                    relatedBy: NSLayoutRelation.equal,
                    toItem: self,
                    attribute: attribute,
                    multiplier: 1,
                    constant: 0
                )
            )
        }
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutAttribute.bottom)
    }
}

