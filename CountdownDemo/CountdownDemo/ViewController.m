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
    
    XNCountDownView *graView = [[XNCountDownView alloc] initWithFont:BFont(15) TextColor:COLOR_WHITE ViewBackgroundColor:COLOR_WHITE GradientDirection:GradientDirection_LeftToRight BeginColor:cHEXCOLOR(#FF4444) EndColor:cHEXCOLOR(#FF6000)];
    graView.countTime = 3606535;
    [self.view addSubview:graView];
    [graView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
        make.width.offset(view.viewSize.width);
        make.height.offset(view.viewSize.height);
    }];
}


@end
