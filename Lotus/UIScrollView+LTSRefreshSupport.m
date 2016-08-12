//
//  UIScrollView+LTSRefreshSupport.m
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import "UIScrollView+LTSRefreshSupport.h"
#import "LTSHeaderRefreshView.h"
#import <objc/runtime.h>

static const void *kLTSRefreshHeaderKey = &kLTSRefreshHeaderKey;
static const void *kLTSRefreshFooterKey = &kLTSRefreshFooterKey;


@implementation UIScrollView (LTSRefreshSupport)

#pragma mark - Property
- (void)setHeaderRefreshAction:(void (^)())action {
    if (!self.header) {
        LTSHeaderRefreshView *headerView = [[LTSHeaderRefreshView alloc] init];
        self.header = headerView;
    }
}

- (void)setFooterRefreshAction:(void (^)())action {
    
}

- (void)setHeader:(LTSHeaderRefreshView *)header {
    objc_setAssociatedObject(self, &kLTSRefreshHeaderKey, header, OBJC_ASSOCIATION_ASSIGN);
    [self addSubview:header];
}

- (LTSHeaderRefreshView *)header {
    return objc_getAssociatedObject(self, &kLTSRefreshHeaderKey);
}



@end
