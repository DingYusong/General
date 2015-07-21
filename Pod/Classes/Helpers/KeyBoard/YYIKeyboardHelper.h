//
//  YYIKeyboardHelper.h
//  GoldWalletPro
//
//  Created by 丁玉松 on 15/6/4.
//  Copyright (c) 2015年 丁玉松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYIKeyboardAccessoryView.h"

@protocol YYIKeyboardHelperDelegate <NSObject>

@optional
- (void)alttextFieldDidBeginEditing:(UITextField *)textField;
- (void)alttextFieldDidEndEditing:(UITextField *)textField;
- (BOOL)alttextFieldShouldClear:(UITextField *)textField;
- (BOOL)alttextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

- (void)alttextViewDidBeginEditing:(UITextView *)textField;
- (void)alttextViewDidEndEditing:(UITextView *)textView;


@end




@interface YYIKeyboardHelper : NSObject<UITextFieldDelegate, YYIKeyboardAccessoryViewDelegate, UITextViewDelegate>

@property (nonatomic, assign) id <YYIKeyboardHelperDelegate> delegate;

- (id)initWithControllerDelegate:(id <YYIKeyboardHelperDelegate>)delegateObject;

- (void)addAccessaryBarToKeyboard;

@end


