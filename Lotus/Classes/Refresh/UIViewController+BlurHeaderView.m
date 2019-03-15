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
const void *kGradientView = &kGradientView;
const void *kGradientLayer = &kGradientLayer;
const void *kHeaderViewWidth = &kHeaderViewWidth;
const void *kHeaderViewHeight = &kHeaderViewHeight;
const void *kHeaderViewOriginX = &kHeaderViewOriginX;
const void *kHeaderViewOriginY = &kHeaderViewOriginY;

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

- (void)setGradientView:(UIView *)gradientView {
    objc_setAssociatedObject(self, kGradientView, gradientView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)gradientView {
    return objc_getAssociatedObject(self, kGradientView);
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer {
    objc_setAssociatedObject(self, kGradientLayer, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer {
    return objc_getAssociatedObject(self, kGradientLayer);
}

- (void)setHeaderViewWidth:(NSNumber *)headerViewWidth {
    objc_setAssociatedObject(self, kHeaderViewWidth, headerViewWidth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)headerViewWidth {
    return objc_getAssociatedObject(self, kHeaderViewWidth);
}

- (void)setHeaderViewHeight:(NSNumber *)headerViewHeight  {
    objc_setAssociatedObject(self, kHeaderViewHeight, headerViewHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)headerViewHeight {
    return objc_getAssociatedObject(self, kHeaderViewHeight);
}

- (void)setHeaderViewOriginX:(NSNumber *)headerViewOriginX {
    objc_setAssociatedObject(self, kHeaderViewOriginX, headerViewOriginX, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)headerViewOriginX {
    return objc_getAssociatedObject(self, kHeaderViewOriginX);
}

- (void)setHeaderViewOriginY:(NSNumber *)headerViewOriginY {
    objc_setAssociatedObject(self, kHeaderViewOriginY, headerViewOriginY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)headerViewOriginY {
    return objc_getAssociatedObject(self, kHeaderViewOriginY);
}

#pragma mark - Private
- (void)createViewsWithFrame:(CGRect)frame {
    self.headerViewWidth = @(frame.size.width);
    self.headerViewHeight = @(frame.size.height);
    self.headerViewOriginX = @(frame.origin.x);
    self.headerViewOriginY = @(frame.origin.y);
    
    if (self.gradientView == nil) {
        self.gradientView = [[UIView alloc] initWithFrame:frame];
        self.gradientView.backgroundColor = [UIColor colorWithRed:0.0/255.0
                                                            green:168.0/255.0
                                                             blue:225.0/255.0
                                                            alpha:1];
        [self.view addSubview:self.gradientView];
    }
    
    if (self.backgroundImageView == nil) {
        self.backgroundImageView = [[UIImageView alloc] init];
        self.backgroundImageView.frame = frame;
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.backgroundImageView.clipsToBounds = YES;
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

+ (CAGradientLayer *)gradientLayerWithContainer:(UIView *)containerView {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = containerView.bounds;
    UIColor *startColor = [UIColor colorWithRed:0
                                          green:140.0/255.0
                                           blue:190.0/255.0
                                          alpha:1];
    UIColor *endColor = [UIColor clearColor];
    gradientLayer.colors = @[
                             (__bridge id)startColor.CGColor,
                             (__bridge id)endColor.CGColor
                             ];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 0.9);
    return gradientLayer;
}

#pragma mark - Public
- (void)createHeaderViewWithFrame:(CGRect)frame {
    [self createViewsWithFrame:frame];
}

- (void)setupHeaderViewWithImageUrl:(NSString *)imageUrl {
    
}

- (void)setupHeaderViewWithImage:(UIImage *)image {
    self.backgroundImageView.image = image;
}

- (void)updateHeaderViewWithOffestY:(CGFloat)offsetY {
    CGFloat imageH = self.headerViewHeight.floatValue;
    CGFloat imageW = self.headerViewWidth.floatValue;
    CGRect frame = CGRectZero;
    frame.origin.y = self.headerViewOriginY.floatValue;
    CGFloat navigationbarHeight = self.navigationController.navigationBar.bounds.size.height;
    CGFloat topBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + navigationbarHeight;
    CGFloat backgroundImageHeight = self.headerViewHeight.floatValue;
    CGFloat originY = self.headerViewOriginY.floatValue;
    CGFloat alpha = 0;
    if (offsetY <= 0) {
        CGFloat totalOffset = imageH + ABS(offsetY);
        CGFloat rate = totalOffset / imageH;
        frame = CGRectMake(-(imageW * rate - imageW) * 0.5, originY, imageW * rate, totalOffset);
        alpha = ABS(offsetY)/topBarHeight > 1 ? 1 : ABS(offsetY)/topBarHeight;
    } else {
        frame.size.width = imageW;
        frame.size.height = imageH;
        CGFloat limitOffset = backgroundImageHeight - topBarHeight - originY;
        //        printf("limitOffset: %f\n", limitOffset);
        //        printf("topBarHeight: %f\n", topBarHeight);
        //        printf("originY: %f\n", originY);
        //        printf("backgroundImageHeight: %f\n", backgroundImageHeight);
        if (offsetY < limitOffset) {
            frame.origin.y -= offsetY;
        } else {
            frame.origin.y = -limitOffset;
        }
        offsetY -= 30;
        alpha = offsetY/topBarHeight > 1 ? 1 : offsetY/topBarHeight;
    }
    self.backgroundImageView.frame = frame;
    self.gradientView.frame = frame;
    self.blurView.alpha = alpha;
    self.blurView.frame = frame;
}


@end
