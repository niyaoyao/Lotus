//
//  LTSHeaderRefreshView.m
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import "LTSHeaderRefreshView.h"


@interface LTSHeaderRefreshView ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end


@implementation LTSHeaderRefreshView

- (instancetype)init {
    if (self = [super init]) {
        [self initLayer];
    }
    return self;
}

- (void)initLayer {
    self.circleLayer.backgroundColor = [UIColor blueColor].CGColor;
    _circleLayer = [[CAShapeLayer alloc] init];
    _circleLayer.fillColor = [UIColor clearColor].CGColor;
    _circleLayer.strokeColor = [UIColor grayColor].CGColor;
    [self.layer addSublayer:self.circleLayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    CGFloat rate = (-self.scrollView.contentOffset.y)/100.0;
    CGFloat radius = 15;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/4.0+20, self.frame.size.height/2.0)
                                                        radius:radius
                                                    startAngle:0
                                                      endAngle:M_PI*2*rate
                                                     clockwise:YES];
    self.circleLayer.path = path.CGPath;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
