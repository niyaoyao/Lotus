//
//  UIView+ViewBadge.h
//  doutu
//
//  Created by niyao on 8/7/18.
//  Copyright © 2018 dourui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewBadge)

- (void)showBadge:(BOOL)showBadge title:(NSString *)title showBorder:(BOOL)showBorder;
- (void)showBadge:(BOOL)showBadge title:(NSString *)title;
- (void)showBadge:(BOOL)showBadge count:(NSInteger)count;
- (void)showBadge;

@end
