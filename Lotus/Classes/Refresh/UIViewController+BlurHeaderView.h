//
//  UIViewController+BlurHeaderView.h
//
//
//  Created by Yao Ni on 7/7/17.
//  Copyright © 2017 Yao Ni. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kNavigationHeight = 64;
static CGFloat kBackgroundImageHeight = 211;

@interface UIViewController (BlurHeaderView)

- (void)setupHeaderViewWithImage:(UIImage *)image;
- (void)updateHeaderViewWithOffestY:(CGFloat)offsetY;

@end
