//
//  UILabel+STFakeAnimation.m
//  STFakeLabel-ObjC
//
//  Created by TangJR on 12/3/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "UILabel+STFakeAnimation.h"
#import <objc/runtime.h>

static void * STFakeLabelAnimationIsAnimatingKey = &STFakeLabelAnimationIsAnimatingKey;

@interface UILabel ()

@property (assign, nonatomic) BOOL st_isAnimating;

@end

@implementation UILabel (STFakeAnimation)

- (void)st_startAnimationWithDirection:(STFakeAnimationDirection)direction toText:(NSString *)toText {
    if (![toText respondsToSelector:@selector(length)]) {
        return;
    }
    if (self.st_isAnimating) {
        return;
    }
    self.st_isAnimating = YES;
    UILabel *fakeLabel = [UILabel new];
    fakeLabel.text = self.text;
    fakeLabel.frame = self.frame;
    fakeLabel.textAlignment = self.textAlignment;
    fakeLabel.font = self.font;
    fakeLabel.textColor = self.textColor;
    fakeLabel.text = toText;
    [self.superview addSubview:fakeLabel];
    
    CGFloat labelOffsetX = 0;
    CGFloat labelOffsetY = 0;
    CGFloat labelScaleX = 0.1;
    CGFloat labelScaleY = 0.1;
    
    if (direction == STFakeAnimationDown || direction == STFakeAnimationUp) {
        labelOffsetY = direction * CGRectGetHeight(self.bounds) / 4;
        labelScaleX = 1.0;
    }
    if (direction == STFakeAnimationLeft || direction == STFakeAnimationRight) {
        labelOffsetX = direction * CGRectGetWidth(self.bounds) / 2;
        labelScaleY = 1.0;
    }
    fakeLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(labelOffsetX, labelOffsetY));
    
    [UIView animateWithDuration:STFakeLabelAnimationDuration animations:^{
        fakeLabel.transform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(labelScaleX, labelScaleY), CGAffineTransformMakeTranslation(-labelOffsetX, -labelOffsetY));
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        [fakeLabel removeFromSuperview];
        self.text = toText;
        self.st_isAnimating = NO;
    }];
}

- (BOOL)st_isAnimating {
    NSNumber *isAnimatingNumber = objc_getAssociatedObject(self, STFakeLabelAnimationIsAnimatingKey);
    return isAnimatingNumber.boolValue;
}

- (void)setSt_isAnimating:(BOOL)st_isAnimating {
    objc_setAssociatedObject(self, STFakeLabelAnimationIsAnimatingKey, @(st_isAnimating), OBJC_ASSOCIATION_ASSIGN);
}

@end