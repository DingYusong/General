//
//  UIImageView+RoundCorner.h
//  ALC
//
//  Created by 丁玉松 on 8/2/14.
//  Copyright (c) 2014 Ganpu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RoundCorner)
//切成圆角
-(void)setRoundCorner;
//椭圆而且还加外圈灰色框
-(void)addCircularFrame;

-(void)setRoundCornerWithCornerRadio:(CGFloat)Radio;

@end

