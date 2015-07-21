//
//  YYIKeyboardAccessoryView.h
//  GoldWalletPro
//
//  Created by 丁玉松 on 15/6/4.
//  Copyright (c) 2015年 丁玉松. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYIKeyboardAccessoryViewDelegate <NSObject>

- (void)toolbarButtonTap:(UIButton *)button;

@end


@interface YYIKeyboardAccessoryView : UIView

@property (nonatomic, assign) id <YYIKeyboardAccessoryViewDelegate> delegate;

@end


@interface YYIKeyboardAccessoryView (UIKeyboardViewAction)

- (UIBarButtonItem *)itemForIndex:(NSInteger)itemIndex;

@end
