//
//  LTSRefreshView.h
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kLTSScrollContentOffset = @"contentOffset";
static const CGFloat refresh_height         = 80;
static const CGFloat refresh_y  = -refresh_height;

@interface LTSRefreshView : UIView

@property (nonatomic, weak, readonly, nullable) UIScrollView *scrollView;

@end
