//
//  UIViewController+BlurHeaderView.h
//
//
//  Created by Yao Ni on 7/7/17.
//  Copyright © 2017 Yao Ni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (BlurHeaderView)

- (void)createHeaderViewWithFrame:(CGRect)frame;
- (void)setupHeaderViewWithImage:(UIImage *)image;
- (void)setupHeaderViewWithImageUrl:(NSString *)imageUrl;
- (void)updateHeaderViewWithOffestY:(CGFloat)offsetY;

@end
