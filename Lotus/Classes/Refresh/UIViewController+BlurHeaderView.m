//
//  UIViewController+BlurHeaderView.m
//
//
//  Created by Yao Ni on 7/7/17.
//  Copyright © 2017 Yao Ni. All rights reserved.
//

#import "UIViewController+BlurHeaderView.h"
#import <objc/runtime.h>

const void *kBackgroundImageView = &kBackgroundImageView;
const void *kBlurView = &kBlurView;

@interface UIViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation UIViewController (BlurHeaderView)

#pragma mark - Getter && Setter
- (void)setBackgroundImageView:(UIImageView *)backgroundImageView {
    objc_setAssociatedObject(self, kBackgroundImageView, backgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return objc_getAssociatedObject(self, kBackgroundImageView);
}

- (void)setBlurView:(UIVisualEffectView *)blurView {
    objc_setAssociatedObject(self, kBlurView, blurView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIVisualEffectView *)blurView {
    return objc_getAssociatedObject(self, kBlurView);
}

#pragma mark - Private
- (void)createViews {
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = kBackgroundImageHeight;
    CGRect frame = CGRectMake(x, y, w, h);
    if (self.backgroundImageView == nil) {
        self.backgroundImageView = [[UIImageView alloc] init];
        self.backgroundImageView.frame = frame;
        self.backgroundImageView.contentMode = UIViewContentModeRedraw;
        [self.view addSubview:self.backgroundImageView];
    }
    
    if (self.blurView == nil) {
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        self.blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
        self.blurView.frame = frame;
        self.blurView.alpha = 0;
        [self.view addSubview:self.blurView];
    }
}

#pragma mark - Navigation
- (void)setupNavigation {
    if (self.navigationController.navigationBar) {
        UINavigationBar *navigationBar = self.navigationController.navigationBar;
        [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        [navigationBar setShadowImage:[UIImage new]];
    }
}

#pragma mark - Public
- (void)setupHeaderViewWithImageUrl:(NSString *)imageUrl {
    
}

- (void)setupHeaderViewWithImage:(UIImage *)image {
    [self setupNavigation];
    [self createViews];
    self.backgroundImageView.image = image;
    [self.view sendSubviewToBack:self.backgroundImageView];
}

- (void)updateHeaderViewWithOffestY:(CGFloat)offsetY {
    CGFloat imageH = kBackgroundImageHeight;
    CGFloat imageW = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectZero;
    CGFloat alpha = 0;
    if (offsetY < 0) {
        CGFloat totalOffset = imageH + ABS(offsetY);
        CGFloat rate = totalOffset / imageH;
        frame = CGRectMake(-(imageW * rate - imageW) * 0.5, 0, imageW * rate, totalOffset);
        alpha = ABS(offsetY)/kNavigationHeight > 1 ? 1 : ABS(offsetY)/kNavigationHeight;
    } else {
        frame.size.width = imageW;
        frame.size.height = imageH;
        if (offsetY < kNavigationHeight) {
            frame.origin.y -= offsetY;
        } else {
            frame.origin.y = -kNavigationHeight;
        }
        offsetY -= 30;
        alpha = offsetY/kNavigationHeight > 1 ? 1 : offsetY/kNavigationHeight;
    }
    self.backgroundImageView.frame = frame;
    self.blurView.alpha = alpha;
    self.blurView.frame = frame;
}


@end
