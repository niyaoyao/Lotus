//
//  LTSViewController.m
//  Lotus
//
//  Created by niyaoyao on 07/11/2017.
//  Copyright (c) 2017 niyaoyao. All rights reserved.
//

#import "LTSViewController.h"
#import "Lotus.h"

@interface LTSViewController ()

@property (nonatomic, strong) UIScrollView *srollView;
@property (nonatomic, strong) UIView *testView;

@end

@implementation LTSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.testView];
}

- (UIView *)testView {
    if (!_testView) {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 50)];
        _testView.backgroundColor = UIColor.blueColor;
    }
    return _testView;
}
@end
