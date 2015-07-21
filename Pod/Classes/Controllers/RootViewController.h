//
//  BaseViewController.h
//  GoldWallet
//
//  Created by felecia on 14-6-10.
//  Copyright (c) 2014年 Beijing Yingyan Internet Co., Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYIKeyboardHelper.h"


@class MBProgressHUD;
@interface RootViewController : UIViewController<YYIKeyboardHelperDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, retain)MBProgressHUD *hud;
@property (nonatomic,assign) BOOL disableKeyboardConnect;
@property (nonatomic ,strong) YYIKeyboardHelper *keyboardHelper;
@property (nonatomic,assign) BOOL disableGestureBack;
@property (nonatomic,assign) BOOL isTestBuild;


//网络加载中
- (void)showHUD:(NSString *)title isDim:(BOOL)isDim;
- (void)hiddenHUD;

//显示提示框
- (void)showTips:(NSString *)text;


//手势处理
-(void)handleTapGesture:(UITapGestureRecognizer *)tapGesture;
-(void)addTapGestureTo:(UIView *)view;

// 回到上一页
- (void)goBack:(UIButton *)button;

@end
