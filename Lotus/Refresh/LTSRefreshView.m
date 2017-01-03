//
//  LTSRefreshView.m
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import "LTSRefreshView.h"
#import "UIView+LTSSupport.h"

@interface LTSRefreshView ()

@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation LTSRefreshView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self.superview removeObserver:self
                            forKeyPath:kLTSScrollContentOffset
                               context:nil];
    } else {
        [newSuperview addObserver:self
                         forKeyPath:kLTSScrollContentOffset
                            options:NSKeyValueObservingOptionNew
                            context:nil];
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollView.alwaysBounceVertical = YES;
        self.backgroundColor = [UIColor blueColor];
        self.frame = [self rectWithFrame:CGRectMake(0, kRefreshViewY,
                                                    self.scrollView.frame.size.width,
                                                    kRefreshViewHeight)];
    }
}

#pragma mark - Life cycle
- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
