//
//  UIView+LTSSupport.m
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import "UIView+LTSSupport.h"

@implementation UIView (LTSSupport)

- (CGRect)rectWithFrame:(CGRect)frame {
    CGRect rect = self.frame;
    rect.origin.x    = frame.origin.x;
    rect.origin.y    = frame.origin.y;
    rect.size.height = frame.size.height;
    rect.size.width  = frame.size.width;
    return rect;
}

@end
