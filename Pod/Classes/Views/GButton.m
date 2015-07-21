//
//  GButton.m
//  GoldWallet
//
//  Created by perrygao on 14-9-29.
//  Copyright (c) 2014年 Beijing Yingyan Internet Co., Ltd.. All rights reserved.
//


#import "GButton.h"
#import "UIColor+RGBValue.h"




@implementation GButton

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [self setup];
}

- (void)setup {
    
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    if (self.enabled) {
        
        self.backgroundColor = [UIColor ColorFromRGB:@"#f0bc00"];
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor ColorFromRGB:@"f1f1f1"].CGColor;
    } else {
        
        self.backgroundColor = [UIColor grayColor];
        self.layer.borderWidth = 0;
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    [self setup];
}
@end
