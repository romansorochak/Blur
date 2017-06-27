//
//  UIView+Blur.swift
//  Blur
//
//  Created by Roman Sorochak <roman.sorochak@gmail.com> on 6/27/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit

extension UIView {
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    class BlurView {
        
        private (set) var superview: UIView
        private (set) var blur: UIVisualEffectView?
        private var editing: Bool = false
        
        var animationDuration: TimeInterval = 0.1
        
        var style: UIBlurEffectStyle = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        var vibrancy: Bool = true {
            didSet {
                guard oldValue != vibrancy,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }
        
        init(to view: UIView) {
            self.superview = view
        }
        
        func setup(style: UIBlurEffectStyle, vibrancy: Bool, alpha: CGFloat) -> Self {
            self.editing = true
            
            self.style = style
            self.vibrancy = vibrancy
            self.alpha = alpha
            
            self.editing = false
            
            return self
        }
        
        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }
            
            self.blur?.isHidden = isHidden
        }
        
        private func applyBlurEffect() {
            blur?.removeFromSuperview()
            blur = applyBlurEffect(
                style: style,
                vibrancy: vibrancy,
                blurAlpha: alpha
            )
        }
        
        private func applyBlurEffect(style: UIBlurEffectStyle,
                                     vibrancy: Bool,
                                     blurAlpha: CGFloat) -> UIVisualEffectView {
            superview.backgroundColor = UIColor.clear
            
            let blurEffectView: UIVisualEffectView = {
                let blurEffect = UIBlurEffect(style: style)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                blurEffectView.translatesAutoresizingMaskIntoConstraints = false
                
                guard vibrancy else {
                    return blurEffectView
                }
                
                let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
                let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
                blurEffectView.contentView.addSubview(vibrancyView)
                
                return blurEffectView
            }()
            
            blurEffectView.alpha = blurAlpha
            
            superview.insertSubview(blurEffectView, at: 0)
            
            func addAlignConstraintToSuperview(attribute: NSLayoutAttribute) {
                superview.addConstraint(
                    NSLayoutConstraint(
                        item: blurEffectView,
                        attribute: attribute,
                        relatedBy: NSLayoutRelation.equal,
                        toItem: superview,
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
            
            return blurEffectView
        }
    }
}
