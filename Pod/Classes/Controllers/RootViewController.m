//
//  RootViewController.m
//  GoldWallet
//
//  Created by felecia on 14-6-10.
//  Copyright (c) 2014年 Beijing Yingyan Internet Co., Ltd.. All rights reserved.
//

#import "RootViewController.h"
#import <MBProgressHUD.h>
#import "UIUtils.h"
#import "GeneralConst.h"
#import "UIViewExt.h"
#import <QuartzCore/QuartzCore.h>

#import "RootNavigationController.h"

@interface RootViewController ()
{
    UIView *_loadView;
}

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    return self;
}

- (void)goBack:(UIButton *)button
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    
    if (_keyboardHelper) {
        _keyboardHelper = nil;
    }
}

#pragma mark - loading

- (void)showHUD:(NSString *)title isDim:(BOOL)isDim
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    self.hud.dimBackground = isDim;
}

- (void)hiddenHUD
{
    [self.hud hide:NO];
}


#pragma mark -  tips

- (void)showTips:(NSString *)text
{
    
    text = [self  dealTipsString:text];

    if (_loadView != nil)
    {
        _loadView.alpha = 0;
        _loadView = nil;
        [_loadView removeFromSuperview];
    }
    
    _loadView = [[UIView alloc] initWithFrame:CGRectZero];
    _loadView.backgroundColor = [UIColor blackColor];
    _loadView.layer.masksToBounds = YES;
    _loadView.layer.cornerRadius = 4.0;
    _loadView.layer.borderWidth = 1.0;
    _loadView.layer.borderColor = [[UIColor clearColor] CGColor];
    
    _loadView.alpha = 0.7;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    
    UIFont *font = label.font;            //跟label的字体大小一样
    CGSize constrainSize = CGSizeMake(ScreenWidth - 40 - 60 , 29999); //跟label的宽设置一样
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size =[text boundingRectWithSize:constrainSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;

    CGRect rect = label.frame;
    rect.size = size;
    label.frame = rect;
    
    label.textColor = [UIColor whiteColor];
    label.left = (ScreenWidth-label.width)/2;
    
    _loadView.frame = CGRectMake((ScreenWidth - (label.width + 40))/2, (ScreenHeight-20-44)/2, label.width+40, label.height+20);
    
    label.left = 20;
    label.top = 10;
    [_loadView addSubview:label];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_loadView];
    [self performSelector:@selector(hiddenTips) withObject:self afterDelay:2];
}

-(NSString *)dealTipsString:(NSString *)string
{
    if (!self.isTestBuild) {
        NSRange range = [string rangeOfString:@"#"];
        
        if (range.location != NSNotFound) {
            NSArray *resuArr = [string componentsSeparatedByString:@"#"];
            return [resuArr objectAtIndex:1];
        }
    }
    return string;
}


- (void)hiddenTips
{
    [UIView animateWithDuration:0.2 animations:^{
        
        CGAffineTransform newTransform =
        CGAffineTransformScale(_loadView.transform, 0.7, 0.7);
        [_loadView setTransform:newTransform];
        _loadView.center = _loadView.center;
        
    }completion:^(BOOL finished) {

        [UIView animateWithDuration:0.4 animations:^{
            _loadView.alpha = 0;
        }completion:^(BOOL finished) {
            [_loadView removeFromSuperview];
        }];   
    }];
}


#pragma mark -  add TapGesture

-(void)addTapGestureTo:(UIView *)view
{
    view.userInteractionEnabled = YES;
    //1、创建手势实例，并连接方法handleTapGesture,点击手势
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    [view addGestureRecognizer:tapGesture];
}


-(void)handleTapGesture:(UITapGestureRecognizer *)tapGesture
{
    
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    if (!self.disableKeyboardConnect) {
        _keyboardHelper=[[YYIKeyboardHelper alloc] initWithControllerDelegate:self];
        [_keyboardHelper addAccessaryBarToKeyboard];
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.view endEditing:YES];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

}




- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.disableGestureBack) {
        if (gestureRecognizer == self.navigationController.interactivePopGestureRecognizer) {
            return NO;
        }
    }
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    NSInteger count = self.navigationController.viewControllers.count;
    if (count > 1)
    {
        UIButton *leftbButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftbButton setFrame:CGRectMake(0, 0, 22, 22)];
        if (!self.navigationItem.hidesBackButton) {
            [leftbButton setImage:[UIImage imageNamed:@"GoBackIcon"] forState:UIControlStateNormal];
            [leftbButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setFrame:CGRectMake(0, 0, 22, 22)];

        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightItem;
    } else {
        self.navigationItem.hidesBackButton = YES;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
