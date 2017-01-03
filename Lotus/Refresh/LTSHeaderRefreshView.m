//
//  LTSHeaderRefreshView.m
//  NYUIFramework
//
//  Created by NiYao on 8/12/16.
//  Copyright © 2016 SuneBearNi. All rights reserved.
//

#import "LTSHeaderRefreshView.h"
#import "LTSMacro.h"


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

#pragma mark - Private

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        _circleLayer = [[CAShapeLayer alloc] init];
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = [UIColor grayColor].CGColor;
    }
    return _circleLayer;
}

- (void)initLayer {
    self.circleLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layer addSublayer:self.circleLayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    CGFloat rate = (-self.scrollView.contentOffset.y)/100.0;
    CGFloat radius = 15;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGFloat x = self.frame.size.width/2.0;
    CGFloat y = self.frame.size.height/2.0;
    CGPoint center = CGPointMake(x, y);
    CGFloat startAngle = - M_PI * 1/2;
    CGFloat endAngle = M_PI * 2 * fabs(rate) + startAngle;
    if (fabs(rate) < 1) {
        [path addArcWithCenter:center
                        radius:radius
                    startAngle:startAngle
                      endAngle:endAngle
                     clockwise:YES];
        self.circleLayer.path = path.CGPath;
    }
    LTSLog(@"%f, %f, %f, %f, %f, %f, %f, %f", self.scrollView.contentOffset.y, rate, startAngle, endAngle, center.x, center.y, self.frame.origin.x, self.frame.origin.y);
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
