//
//  UILabel+STFakeAnimation.h
//  STFakeLabel-ObjC
//
//  Created by TangJR on 12/3/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, STFakeAnimationDirection) {
    STFakeAnimationRight = 1,       ///< left to right
    STFakeAnimationLeft = -1,       ///< right to left
    STFakeAnimationDown = -2,       ///< up to down
    STFakeAnimationUp = 2           ///< down to up
};

// animation duration
static const NSTimeInterval STFakeLabelAnimationDuration = 0.7;

@interface UILabel (STFakeAnimation)

- (void)st_startAnimationWithDirection:(STFakeAnimationDirection)direction toText:(NSString *)toText;

@end