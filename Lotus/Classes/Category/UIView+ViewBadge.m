//
//  UIView+ViewBadge.m
//  doutu
//
//  Created by niyao on 8/7/18.
//  Copyright © 2018 dourui. All rights reserved.
//

#import "UIView+ViewBadge.h"
#import <objc/runtime.h>

const void *kBadgeLable = &kBadgeLable;
const void *kBadgeView = &kBadgeView;

@interface UIView ()

@property (nonatomic, strong) UILabel *badgeLable;

@end

@implementation UIView (ViewBadge)

- (void)setBadgeLable:(UILabel *)badgeLable {
    objc_setAssociatedObject(self, kBadgeLable, badgeLable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)badgeLable {
    return objc_getAssociatedObject(self, kBadgeLable);
}

- (void)showBadge:(BOOL)showBadge count:(NSInteger)count {
    [self showBadge:showBadge title:count > 0 ? [NSString stringWithFormat:@"%ld", (long)count] : @"" showBorder:NO];
}

- (void)showBadge:(BOOL)showBadge title:(NSString *)title {
    [self showBadge:showBadge title:title showBorder:NO];
}

- (void)showBadge:(BOOL)showBadge title:(NSString *)title showBorder:(BOOL)showBorder {
    CGRect parentFrame = self.frame;
    CGSize badgeSize = CGSizeZero;
    UIFont *font = [UIFont boldSystemFontOfSize:8];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 20)
                                      options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:attributes context:nil].size;
    badgeSize = [title sizeForFont:font size:CGSizeMake(MAXFLOAT, 20) mode:NSLineBreakByCharWrapping];
    badgeSize.height += 4;
    badgeSize.width += 5;
    CGRect rect = CGRectZero;
    if (self.badgeLable == nil) {
        rect.origin.x = parentFrame.size.width - 1/2.0 * badgeSize.width;
        rect.origin.y = 0;
        rect.size.width = badgeSize.width;
        rect.size.height = badgeSize.height;
        self.badgeLable = [[UILabel alloc] initWithFrame:rect];
        [self addSubview:self.badgeLable];
    }
    
    if (title.length > 0) {
        self.badgeLable.hidden = !showBadge;
    } else {
        self.badgeLable.hidden = YES;
    }
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
    [self showBadge:YES count:1];
}

@end
