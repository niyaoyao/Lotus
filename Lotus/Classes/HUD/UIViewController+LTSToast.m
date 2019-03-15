//
//  UIViewController+LTSToast.m
//  Lotus
//
//  Created by niyao  on 2019/3/15.
//  Copyright © 2019 niyao. All rights reserved.
//

#import "UIViewController+LTSToast.h"
#import <objc/runtime.h>

const  void  *kLTSToastMessageLabel                = &kLTSToastMessageLabel;
static const NSTimeInterval kAnimateDuration = 0.25;
static const NSTimeInterval kLongDistance    = 5;
static const NSTimeInterval kShortDistance   = 2;
static const CGFloat kCornerRadius           = 5;

@interface UIViewController ()

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation UIViewController (LTSToast)

- (void)setMessageLabel:(UILabel *)messageLable {
    objc_setAssociatedObject(self, kLTSToastMessageLabel, messageLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)messageLabel {
    return objc_getAssociatedObject(self, kLTSToastMessageLabel);
}

#pragma mark - Public Method
- (void)showMessage:(NSString *)message interval:(NSTimeInterval)interval completion:(void (^)(void))showMessageCompletion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!weakSelf.messageLabel) {
            weakSelf.messageLabel = [[UILabel alloc] init];
        }
        
        weakSelf.messageLabel.frame               = [UIViewController labelRectWithString:message
                                                                                     font:weakSelf.messageLabel.font];
        weakSelf.messageLabel.text                = message;
        weakSelf.messageLabel.textColor           = [UIColor whiteColor];
        weakSelf.messageLabel.backgroundColor     = [UIColor colorWithWhite:0 alpha:0.8];
        weakSelf.messageLabel.alpha               = 0;
        weakSelf.messageLabel.textAlignment       = NSTextAlignmentCenter;
        weakSelf.messageLabel.layer.cornerRadius  = kCornerRadius;
        weakSelf.messageLabel.layer.masksToBounds = YES;
        weakSelf.messageLabel.numberOfLines = 0;
        
        [weakSelf.view addSubview:weakSelf.messageLabel];
        [UIView animateWithDuration:kAnimateDuration animations:^{
            weakSelf.messageLabel.alpha = 1;
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:kAnimateDuration animations:^{
            weakSelf.messageLabel.alpha = 0;
        } completion:^(BOOL finished) {
            [weakSelf.messageLabel removeFromSuperview];
            weakSelf.messageLabel = nil;
            if (showMessageCompletion) {
                showMessageCompletion();
            }
        }];
    });
}

- (void)showMessage:(NSString *)message interval:(NSTimeInterval)interval {
    [self showMessage:message interval:interval completion:nil];
}

- (void)showMessageForLongDistance:(NSString *)message {
    [self showMessage:message interval:kLongDistance];
}

- (void)showMessageForShortDistance:(NSString *)message {
    [self showMessage:message interval:kShortDistance];
}

#pragma mark - Pravite Method

+ (CGRect)labelRectWithString:(NSString *)message font:(UIFont *)font {
    CGFloat screenHeight       = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenWidth        = [UIScreen mainScreen].bounds.size.width;
    CGFloat messageLabelY      = screenHeight * 0.4;
    CGFloat messageLabelLeft   = 50;
    CGFloat messageLabelWidth  = screenWidth - 2 * messageLabelLeft;
    CGFloat messageLabelHeight = [message boundingRectWithSize:CGSizeMake(messageLabelWidth, MAXFLOAT)
                                                       options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:@{NSFontAttributeName:font}
                                                       context:nil].size.height + 30;
    CGRect rect = CGRectMake(messageLabelLeft, messageLabelY, messageLabelWidth, messageLabelHeight);
    return rect;
}

@end
