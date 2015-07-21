//
//  UIImageView+RoundCorner.m
//  ALC
//
//  Created by 丁玉松 on 8/2/14.
//  Copyright (c) 2014 Ganpu. All rights reserved.
//

#import "UIImageView+RoundCorner.h"

@implementation UIImageView (RoundCorner)

-(void)setRoundCorner
{
    [self.layer setCornerRadius:5];
    [self.layer setMasksToBounds:YES];
    
    [self setContentMode:UIViewContentModeScaleAspectFill];
}


-(void)setRoundCornerWithCornerRadio:(CGFloat)Radio
{
    [self.layer setCornerRadius:Radio];
    [self.layer setMasksToBounds:YES];
    
    [self setContentMode:UIViewContentModeScaleAspectFill];
}


-(void)addCircularFrame
{
    [self setRoundCorner];
    [self setClipsToBounds:YES];
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.layer.borderWidth = 1.0f;
    
}


@end
