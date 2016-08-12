//
//  UIScrollView+LTSRefreshSupport.h
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LTSRefreshSupport)

- (void)setHeaderRefreshAction:(void (^)())action;
- (void)setFooterRefreshAction:(void (^)())action;

@end
