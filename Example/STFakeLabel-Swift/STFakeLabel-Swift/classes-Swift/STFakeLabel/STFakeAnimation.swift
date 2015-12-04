//
//  STFakeAnimation.swift
//  STFakeLabel-Swift
//
//  Created by TangJR on 12/4/15.
//  Copyright © 2015 tangjr. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be included
//  in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
//  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
//  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

/**
 STFakeAnimation is an Swift extension that adds fake 3D animation to UIlabel
 object class. It is intended to be simple, lightweight, and easy to use.
 Animate just need a single line of code
 
 'st_startAnimation' method animate with direction and new text
 */
extension UILabel {
    
    enum STFakeAnimationDirection: Int {
        case Right = 1       ///< left to right
        case Left = -1       ///< right to left
        case Down = -2       ///< up to down
        case Up = 2          ///< down to up
    }
    
    func st_startAnimation(direction: STFakeAnimationDirection, toText: String!) {
        if st_isAnimatin! {
            return
        }
        st_isAnimatin = true
        
        let fakeLabel = UILabel()
        fakeLabel.frame = frame
        fakeLabel.text = toText
        fakeLabel.textAlignment = textAlignment
        fakeLabel.textColor = textColor
        fakeLabel.font = font
        self.superview!.addSubview(fakeLabel)
        
        var labelOffsetX: CGFloat = 0.0
        var labelOffsetY: CGFloat = 0.0
        var labelScaleX: CGFloat = 0.1
        var labelScaleY: CGFloat = 0.1
        
        if direction == .Down || direction == .Up {
            labelOffsetY = CGFloat(direction.rawValue) * CGRectGetHeight(bounds) / 4.0;
            labelScaleX = 1.0;
        }
        if direction == .Left || direction == .Right {
            labelOffsetX = CGFloat(direction.rawValue) * CGRectGetWidth(bounds) / 2.0;
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