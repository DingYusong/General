//
//  YYIKeyboardHelper.m
//  GoldWalletPro
//
//  Created by 丁玉松 on 15/6/4.
//  Copyright (c) 2015年 丁玉松. All rights reserved.
//

#import "YYIKeyboardHelper.h"

static CGFloat kboardHeight = 254.0f;
static CGFloat keyBoardToolbarHeight = 45.0f;
static CGFloat spacerY = 20.0f;
static CGFloat viewFrameY = 0;

@interface YYIKeyboardHelper ()
{
    CGRect keyboardBounds;
    
    YYIKeyboardAccessoryView *view_keyboardToolbar;
    
    UIView *view_targetObject;
}

@end



@implementation YYIKeyboardHelper

- (void)dealloc {
    

    // gyc for ios7 让所有的 输入视图 失去焦点,否则会闪退
    NSArray * arrs = [self allSubviews:view_targetObject];
    for (id view in arrs) {
        if ([view isKindOfClass:[UITextView class]] || [view isKindOfClass:[UITextField class]]) {
     
            [view resignFirstResponder];
        }
    }    

    self.delegate = nil;
    [self removeKeyBoardNotification];
}


- (id)initWithControllerDelegate:(id <YYIKeyboardHelperDelegate>)delegateObject {
    if (self = [super init]) {
        
        self.delegate = delegateObject;
        
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            view_targetObject = [(UIViewController *)[self delegate] view];
        }
        else if ([self.delegate isKindOfClass:[UIView class]]) {
            view_targetObject = (UIView *)[self delegate];
        }
        
        viewFrameY = view_targetObject.frame.origin.y;
        
        [self addKeyBoardNotification];
    }
    return self;
}

//给键盘加上toolbar
- (void)addAccessaryBarToKeyboard {
    
    view_keyboardToolbar = [[YYIKeyboardAccessoryView alloc] initWithFrame:CGRectMake(0, 0, view_targetObject.frame.size.width, keyBoardToolbarHeight)];
    if ([view_keyboardToolbar respondsToSelector:@selector(tintColor)]) {
        [view_keyboardToolbar setTintColor:[UIColor whiteColor]];
    }
    view_keyboardToolbar.delegate = self;
    
    for (id aview in [self allSubviews:view_targetObject]) {
        if ([aview isKindOfClass:[UITextField class]]) {
            ((UITextField *)aview).inputAccessoryView = view_keyboardToolbar;
            ((UITextField *)aview).delegate = self;
        }
        else if ([aview isKindOfClass:[UITextView class]]) {
            ((UITextView *)aview).inputAccessoryView = view_keyboardToolbar;
            ((UITextView *)aview).delegate = self;
        }
    }
}


//监听键盘隐藏和显示事件
- (void)addKeyBoardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
}

//注销监听事件
- (void)removeKeyBoardNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

//计算当前键盘的高度
-(void)keyboardWillShowOrHide:(NSNotification *)notification {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
#endif
        kboardHeight = 264.0f + keyBoardToolbarHeight;
    }
    
    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    [keyboardBoundsValue getValue:&keyboardBounds];
    
    BOOL isShow = [[notification name] isEqualToString:UIKeyboardWillShowNotification] ? YES : NO;
    
    if ([self firstResponder:view_targetObject]) {
        [self animateView:isShow textField:[self firstResponder:view_targetObject]
        heightforkeyboard:keyboardBounds.size.height];
    }
}

#pragma mark - Responder

//输入框获得焦点
- (id)firstResponder:(UIView *)navView {
    for (id aview in [self allSubviews:navView]) {
        if ([aview isKindOfClass:[UITextField class]] && [(UITextField *)aview isFirstResponder]) {
            return (UITextField *)aview;
        }
        else if ([aview isKindOfClass:[UITextView class]] && [(UITextView *)aview isFirstResponder]) {
            return (UITextView *)aview;
        }
    }
    return nil;
}
//输入框失去焦点，隐藏键盘
- (void)resignKeyboard:(UIView *)resignView {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


//找出所有的subview
- (NSArray *)allSubviews:(UIView *)theView {
    NSArray *results = [theView subviews];
    for (UIView *eachView in [theView subviews]) {
        NSArray *riz = [self allSubviews:eachView];
        if (riz) {
            results = [results arrayByAddingObjectsFromArray:riz];
        }
        
        // 就是想找到 textfield  gyc add
        if ([eachView isKindOfClass:[UITableView class]]) {
            
            NSArray * cells = [(UITableView *)eachView visibleCells];
            
            for (UITableViewCell * cell in cells) {
                
                NSArray * rtz = [self allSubviews:cell];
                if (rtz) {
                    [results   arrayByAddingObjectsFromArray:rtz];
                }
            }
        }
        // end
    }
    return results;
}


#pragma mark - animation move

//输入框上移防止键盘遮挡
- (void)animateView:(BOOL)isShow textField:(id)textField heightforkeyboard:(CGFloat)kheight {
    kboardHeight = kheight;
    [self checkBarButton:textField];

    CGRect rect = view_targetObject.frame;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    if (isShow) {
        if ([textField isKindOfClass:[UITextField class]]) {
            UITextField *newText = ((UITextField *)textField);
            
            CGPoint textPoint = [newText convertPoint:CGPointMake(0, newText.frame.size.height + spacerY) toView:view_targetObject];
            
            if (rect.size.height - textPoint.y < kheight)
            {
                rect.origin.y = rect.size.height - textPoint.y - kheight + viewFrameY;
            }
            else
            {
                rect.origin.y = viewFrameY;
            }
        }
        else {
            UITextView *newView = ((UITextView *)textField);
            CGPoint textPoint = [newView convertPoint:CGPointMake(0, newView.frame.size.height + spacerY) toView:view_targetObject];
            if (rect.size.height - textPoint.y < kheight)
                rect.origin.y = rect.size.height - textPoint.y - kheight + viewFrameY;
            else rect.origin.y = viewFrameY;
        }
    }
    else rect.origin.y = viewFrameY;
    
    view_targetObject.frame = rect;
    
    NSLog(@"view_targetObject.tag:%ld",(long)view_targetObject.tag);
    
    [UIView commitAnimations];
}


//设置previousBarItem或nextBarItem是否允许点击
- (void)checkBarButton:(id)textField {
    int i = 0,j = 0;
    UIBarButtonItem *previousBarItem = [view_keyboardToolbar itemForIndex:0];
    UIBarButtonItem *nextBarItem = [view_keyboardToolbar itemForIndex:1];
    for (id aview in [self allSubviews:view_targetObject]) {
        if ([aview isKindOfClass:[UITextField class]] && ((UITextField*)aview).userInteractionEnabled && ((UITextField*)aview).enabled) {
            i++;
            if ([(UITextField *)aview isEqual:textField]) {
                j = i;
            }
        }
        else if ([aview isKindOfClass:[UITextView class]] && ((UITextView*)aview).userInteractionEnabled && ((UITextView*)aview).editable) {
            i++;
            if ([(UITextView *)aview isEqual:textField]) {
                j = i;
            }
        }
    }
    [previousBarItem setEnabled:j > 1 ? YES : NO];
    [nextBarItem setEnabled:j < i ? YES : NO];
}

#pragma mark - TextField delegate methods


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self checkBarButton:textField];
    if ([self.delegate respondsToSelector:@selector(alttextFieldDidBeginEditing:)]) {
        [self.delegate alttextFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(alttextFieldShouldClear:)]) {
        [self.delegate alttextFieldShouldClear:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate == nil)
    {
        [textField resignFirstResponder];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(alttextFieldDidEndEditing:)]) {
        [self.delegate alttextFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.delegate respondsToSelector:@selector(alttextField:shouldChangeCharactersInRange:replacementString:)])
    {
        return [self.delegate alttextField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

#pragma mark - UITextView delegate methods
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(alttextViewDidBeginEditing:)]) {
        [self.delegate alttextViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.delegate respondsToSelector:@selector(alttextViewDidEndEditing:)]) {
        [self.delegate alttextViewDidEndEditing:textView];
    }
}

#pragma mark - UIKeyboardView delegate methods
-(void)toolbarButtonTap:(UIButton *)button {
    
    NSInteger buttonTag = button.tag;
    NSMutableArray *textFieldArray=[NSMutableArray arrayWithCapacity:10];
    
    for (id aview in [self allSubviews:view_targetObject]) {
        if ([aview isKindOfClass:[UITextField class]] && ((UITextField*)aview).userInteractionEnabled && ((UITextField*)aview).enabled) {
            [textFieldArray addObject:(UITextField *)aview];
        }
        else if ([aview isKindOfClass:[UITextView class]] && ((UITextView*)aview).userInteractionEnabled && ((UITextView*)aview).editable) {
            [textFieldArray addObject:(UITextView *)aview];
        }
    }
    
    for (int i = 0; i < [textFieldArray count]; i++) {
        id textField = [textFieldArray objectAtIndex:i];
        if ([textField isKindOfClass:[UITextField class]]) {
            textField = ((UITextField *)textField);
        }
        else {
            textField = ((UITextView *)textField);
        }
        if ([textField isFirstResponder]) {
            if (buttonTag == 1) {
                if (i > 0) {
                    [[textFieldArray objectAtIndex:--i] becomeFirstResponder];
                    [self animateView:YES textField:[textFieldArray objectAtIndex:i] heightforkeyboard:kboardHeight];
                }
            }
            else if (buttonTag == 2) {
                if (i < [textFieldArray count] - 1) {
                    [[textFieldArray objectAtIndex:++i] becomeFirstResponder];
                    [self animateView:YES textField:[textFieldArray objectAtIndex:i] heightforkeyboard:kboardHeight];
                }
            }
        }
    }
    if (buttonTag == 3) 
        [self resignKeyboard:view_targetObject];
}


@end
