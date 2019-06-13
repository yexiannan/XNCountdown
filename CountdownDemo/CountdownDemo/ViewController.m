//
//  ViewController.m
//  CountdownDemo
//
//  Created by Luigi on 2019/6/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "ViewController.h"
#import "XNCountDownView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    XNCountDownView *view = [[XNCountDownView alloc] initWithFont:MFont(15) TextColor:COLOR_WHITE TextBackgroundColor:COLOR_BLACK_2C ViewBackgroundColor:COLOR_WHITE];
    view.countTime = 3606535;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.offset(view.viewSize.width);
        make.height.offset(view.viewSize.height);
    }];
    
}


@end
