//
//  ViewController.m
//  STFakeLabel-ObjC
//
//  Created by TangJR on 12/3/15.
//  Copyright © 2015 tangjr. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+STFakeAnimation.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fakeLabel;

- (IBAction)buttonTapped:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonTapped:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    static int flag = 0;
    NSString *toText = flag % 2 ? @"EGG" : @"FALL";
    flag++;
    
    if (tag == 100) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationDown toText:toText];
        return;
    }
    if (tag == 101) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationLeft toText:toText];
        return;
    }
    if (tag == 102) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationRight toText:toText];
        return;
    }
    if (tag == 103) {
        [self.fakeLabel st_startAnimationWithDirection:STFakeAnimationUp toText:toText];
        return;
    }
}

@end