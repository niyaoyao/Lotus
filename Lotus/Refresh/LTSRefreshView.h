//
//  LTSRefreshView.h
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const kLTSScrollContentOffset = @"contentOffset";
static const CGFloat kRefreshViewHeight = 80;
static const CGFloat kRefreshViewY = -kRefreshViewHeight;

typedef NS_ENUM(NSInteger, LTSRefreshStatus) {
    LTSRefreshStatusR,
    LTSRefreshStatusend,
};

@interface LTSRefreshView : UIView

@property (nonatomic, weak, readonly, nullable) UIScrollView *scrollView;
@property (nonatomic, assign) LTSRefreshStatus status;

@end
NS_ASSUME_NONNULL_END
