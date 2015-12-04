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
        case STFakeAnimationUp = 2          ///< down to up
    }
    
    // animate with direction
    // 'toText' is the new text should showing
    func st_startAnimation(direction: STFakeAnimationDirection, toText: String!) {
        // if self is animating, shall not pass!!!
        // set YES when animation is starting
        // set NO when animation completed
        if self.st_isAnimatin! {
            return
        }
        self.st_isAnimatin = true
        
        // copy self to fakeLabel
        let fakeLabel = UILabel()
        fakeLabel.frame = self.frame
        fakeLabel.text = toText
        fakeLabel.textAlignment = self.textAlignment
        fakeLabel.textColor = self.textColor
        fakeLabel.font = self.font
        self.superview!.addSubview(fakeLabel)
        
        var labelOffsetX: CGFloat = 0.0 // label make translation offset x
        var labelOffsetY: CGFloat = 0.0 // label make translation offset y
        var labelScaleX: CGFloat = 0.1 // label make scale x
        var labelScaleY: CGFloat = 0.1 // label make scale y
        
        // if direction is vertical, label offset y is the half of label height and scale x not changed
        // the code below 'CGRectGetHeight(self.bounds) / 4' corse that STFakeAnimationDown / STFakeAnimationUp raw value is -2 / 2
        if direction == .STFakeAnimationDown || direction == .STFakeAnimationUp {
            labelOffsetY = CGFloat(direction.rawValue) * CGRectGetHeight(self.bounds) / 4.0;
            labelScaleX = 1.0;
        }
        // if direction is vertical, label offset x is the half of label width and scale y not changed
        if direction == .STFakeAnimationLeft || direction == .STFakeAnimationRight {
            labelOffsetX = CGFloat(direction.rawValue) * CGRectGetWidth(self.bounds) / 2.0;
            labelScaleY = 1.0;
        }
        // do scale and translation transform with variable
        fakeLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(labelOffsetX, labelOffsetY))
        
        // animation block
        // fake lbael transform identity
        // width / height of self scale result to 0.1, and do translation also
        UIView.animateWithDuration(Config.STFakeLabelAnimationDuration, animations: { () -> Void in
            fakeLabel.transform = CGAffineTransformIdentity
            self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(-labelOffsetX, -labelOffsetY))
            }) { (finish: Bool) -> Void in
                // restore self
                // remove fake label
                // reset aniamtion flag
                self.transform = CGAffineTransformIdentity
                self.text = toText
                fakeLabel.removeFromSuperview()
                self.st_isAnimatin = false
        }
    }
    
    // animation duration
    private struct Config {
        static var STFakeLabelAnimationDuration = 0.7
    }
    
    // st_isAnimating asscoiate key
    private struct AssociatedKeys {
        static var STFakeLabelAnimationIsAnimatingKey = "STFakeLabelAnimationIsAnimatingKey"
    }
    
    // default is false
    private var st_isAnimatin: Bool? {
        get {
            let isAnimating = objc_getAssociatedObject(self, &AssociatedKeys.STFakeLabelAnimationIsAnimatingKey) as? Bool
            // if variable is not set, return false as default
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