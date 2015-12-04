//
//  UILabel+STFakeAnimation.h
//  STFakeLabel-ObjC
//
//  Created by TangJR on 12/3/15.
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, STFakeAnimationDirection) {
    STFakeAnimationRight = 1,       ///< left to right
    STFakeAnimationLeft = -1,       ///< right to left
    STFakeAnimationDown = -2,       ///< up to down
    STFakeAnimationUp = 2           ///< down to up
};

// animation duration
static const NSTimeInterval STFakeLabelAnimationDuration = 0.7;

/**
 STFakeAnimation is an Objective-C category that adds fake 3D animation to UIlabel
 object class. It is intended to be simple, lightweight, and easy to use. 
 Animate just need a single line of code
 
 'st_startAnimationWithDirection: toText:' method animate with direction and new text
 */
@interface UILabel (STFakeAnimation)

- (void)st_startAnimationWithDirection:(STFakeAnimationDirection)direction toText:(NSString *)toText;

@end