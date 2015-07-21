//
//  YYIKeyboardAccessoryView.m
//  GoldWalletPro
//
//  Created by 丁玉松 on 15/6/4.
//  Copyright (c) 2015年 丁玉松. All rights reserved.
//

#import "YYIKeyboardAccessoryView.h"

@interface YYIKeyboardAccessoryView ()
{
    UIToolbar *toolbar_Keyboard;
}
@end

@implementation YYIKeyboardAccessoryView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        toolbar_Keyboard = [[UIToolbar alloc] initWithFrame:frame];
        toolbar_Keyboard.barStyle = UIBarStyleBlackTranslucent;
        
        UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"前一项", @"")
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:self
                                                                           action:@selector(toolbarButtonTap:)];
        previousBarItem.tag=1;
        
        UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"后一项", @"")
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(toolbarButtonTap:)];
        nextBarItem.tag=2;
        
        UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                      target:nil
                                                                                      action:nil];
        
        UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
                                                                        style:UIBarButtonItemStyleDone
                                                                       target:self
                                                                       action:@selector(toolbarButtonTap:)];
        doneBarItem.tag=3;
        
        [toolbar_Keyboard setItems:[NSArray arrayWithObjects:previousBarItem, nextBarItem, spaceBarItem, doneBarItem, nil]];
        [self addSubview:toolbar_Keyboard];
    }
    return self;
}

- (void)toolbarButtonTap:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(toolbarButtonTap:)]) {
        [self.delegate toolbarButtonTap:button];
    }
}

@end

@implementation YYIKeyboardAccessoryView (UIKeyboardViewAction)

//根据index找出对应的UIBarButtonItem
- (UIBarButtonItem *)itemForIndex:(NSInteger)itemIndex {
    
    if (itemIndex < [[toolbar_Keyboard items] count]) {
        return [[toolbar_Keyboard items] objectAtIndex:itemIndex];
    }
    return nil;
}

@end


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

