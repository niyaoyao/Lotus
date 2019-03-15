//
//  UIView+ViewBadge.m
//  doutu
//
//  Created by niyao on 8/7/18.
//  Copyright © 2018 dourui. All rights reserved.
//

#import "UIView+ViewBadge.h"
#import <objc/runtime.h>

const void *kLTSBadgeLable = &kLTSBadgeLable;

@interface UIView ()

@property (nonatomic, strong) UILabel *badgeLable;

@end

@implementation UIView (ViewBadge)

- (void)setBadgeLable:(UILabel *)badgeLable {
    objc_setAssociatedObject(self, kLTSBadgeLable, badgeLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badgeLable {
    return objc_getAssociatedObject(self, kLTSBadgeLable);
}

- (void)showBadge:(BOOL)showBadge count:(NSInteger)count {
    [self showBadge:showBadge title:count > 0 ? [NSString stringWithFormat:@"%ld", (long)count] : @"" showBorder:NO];
}

- (void)showBadge:(BOOL)showBadge title:(NSString *)title {
    [self showBadge:showBadge title:title showBorder:NO];
}

- (void)showBadge:(BOOL)showBadge title:(NSString *)title showBorder:(BOOL)showBorder {
    [self showBadge:showBadge title:title showBorder:showBorder font:[UIFont boldSystemFontOfSize:10]];
}

- (void)showBadge:(BOOL)showBadge title:(NSString *)title showBorder:(BOOL)showBorder font:(UIFont *)font {
    [self showBadge:showBadge title:title showBorder:showBorder font:font width:0 height:0];
}

- (void)showBadge:(BOOL)showBadge title:(NSString *)title showBorder:(BOOL)showBorder font:(UIFont *)font width:(CGFloat)width height:(CGFloat)height {
    CGRect parentFrame = self.frame;
    CGSize badgeSize = CGSizeZero;
    NSDictionary *attributes = @{NSFontAttributeName: font};
    badgeSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                                    options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:attributes context:nil].size;
    
    badgeSize.width = badgeSize.height > badgeSize.width ? badgeSize.height : badgeSize.width;
    badgeSize.height = badgeSize.width;
    badgeSize.width += 4;
    badgeSize.height += 4;
    
    if (width > 0) {
        badgeSize.width = width;
    }
    
    if (height > 0) {
        badgeSize.height = height;
    }
    
    CGRect rect = CGRectZero;
    if (self.badgeLable == nil) {
        rect.origin.x = parentFrame.size.width - 1/2.0 * badgeSize.width;
        rect.origin.y = 0;
        rect.size.width = badgeSize.width;
        rect.size.height = badgeSize.height;
        self.badgeLable = [[UILabel alloc] initWithFrame:rect];
        [self addSubview:self.badgeLable];
    }
    
    self.badgeLable.hidden = !showBadge;
    self.badgeLable.text = title;
    self.badgeLable.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:72.0/255.0  blue:27.0/255.0 alpha:1];
    self.badgeLable.textColor = [UIColor whiteColor];
    self.badgeLable.font = font;
    self.badgeLable.textAlignment = NSTextAlignmentCenter;
    self.badgeLable.layer.cornerRadius = 1/2.0 * badgeSize.height;
    self.badgeLable.layer.masksToBounds = YES;
    self.badgeLable.layer.borderWidth = showBorder ? 1.0 : 0;
    self.badgeLable.layer.borderColor = UIColor.whiteColor.CGColor;
    self.badgeLable.clipsToBounds = YES;
}

- (void)showBadge {
    [self showBadge:YES title:@""];
}

@end
