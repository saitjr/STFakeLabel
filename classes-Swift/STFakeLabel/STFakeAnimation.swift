//
//  STFakeAnimation.swift
//  STFakeLabel-Swift
//
//  Created by TangJR on 12/4/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

import UIKit

extension UILabel {
    
    enum STFakeAnimationDirection: Int {
        case STFakeAnimationRight = 1       ///< left to right
        case STFakeAnimationLeft = -1       ///< right to left
        case STFakeAnimationDown = -2       ///< up to down
        case STFakeAnimationUp = 2           ///< down to up
    }
    
    func st_startAnimation(direction: STFakeAnimationDirection, toText: String!) {
        if self.st_isAnimatin! {
            return
        }
        self.st_isAnimatin = true
        let fakeLabel = UILabel()
        fakeLabel.frame = self.frame
        fakeLabel.text = toText
        fakeLabel.textAlignment = self.textAlignment
        fakeLabel.textColor = self.textColor
        fakeLabel.font = self.font
        self.superview!.addSubview(fakeLabel)
        
        var labelOffsetX: CGFloat = 0.0
        var labelOffsetY: CGFloat = 0.0
        var labelScaleX: CGFloat = 0.1
        var labelScaleY: CGFloat = 0.1
        
        if direction == .STFakeAnimationDown || direction == .STFakeAnimationUp {
            labelOffsetY = CGFloat(direction.rawValue) * CGRectGetHeight(self.bounds) / 4.0;
            labelScaleX = 1.0;
        }
        if direction == .STFakeAnimationLeft || direction == .STFakeAnimationRight {
            labelOffsetX = CGFloat(direction.rawValue) * CGRectGetWidth(self.bounds) / 2.0;
            labelScaleY = 1.0;
        }
        fakeLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(labelOffsetX, labelOffsetY))
        UIView.animateWithDuration(Config.STFakeLabelAnimationDuration, animations: { () -> Void in
            fakeLabel.transform = CGAffineTransformIdentity
            self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(-labelOffsetX, -labelOffsetY))
            }) { (finish: Bool) -> Void in
                self.transform = CGAffineTransformIdentity
                self.text = toText
                fakeLabel.removeFromSuperview()
                self.st_isAnimatin = false
        }
    }
    
    private struct Config {
        static var STFakeLabelAnimationDuration = 0.7
    }
    
    private struct AssociatedKeys {
        static var STFakeLabelAnimationIsAnimatingKey = "STFakeLabelAnimationIsAnimatingKey"
    }
    
    private var st_isAnimatin: Bool? {
        get {
            let isAnimating = objc_getAssociatedObject(self, &AssociatedKeys.STFakeLabelAnimationIsAnimatingKey) as? Bool
            guard let _ = isAnimating else {
                return false
            }
            return isAnimating
        }
        
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.STFakeLabelAnimationIsAnimatingKey, newValue as Bool?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}