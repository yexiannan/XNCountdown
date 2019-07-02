//
//  XNViewController.m
//  XNCountdown
//
//  Created by yexiannan on 07/02/2019.
//  Copyright (c) 2019 yexiannan. All rights reserved.
//

#import "XNViewController.h"
#import "XNCountDownView.h"
#import "Masonry.h"

@interface XNViewController ()

@end

@implementation XNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
        make.centerX.equalTo(view);
        make.width.offset(graView.viewSize.width);
        make.height.offset(graView.viewSize.height);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
