//
//  UIViewController+LTSToast.h
//  Lotus
//
//  Created by niyao  on 2019/3/15.
//  Copyright © 2019 niyao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LTSToast)
/**
 *  长时间显示 HUD
 *
 *  @param message 显示信息
 */
- (void)showMessageForLongDistance:(NSString * _Nullable )message;

/**
 *  显示 HUD 短暂时间
 *
 *  @param message 显示信息
 */
- (void)showMessageForShortDistance:(NSString * _Nullable )message;

/**
 *  自定义 HUD 显示时间
 *
 *  @param message  消息
 *  @param interval 时间
 */
- (void)showMessage:(NSString * _Nullable )message interval:(NSTimeInterval)interval;

/**
 *  自定义 HUD 显示时间
 *
 *  @param message               消息
 *  @param interval              时间
 *  @param showMessageCompletion 回调
 */
- (void)showMessage:(NSString * _Nullable )message
           interval:(NSTimeInterval)interval
         completion:(void (^ _Nullable )(void))showMessageCompletion;

/**
 显示 Toast

 @param message  消息
 */
- (void)showMessage:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
