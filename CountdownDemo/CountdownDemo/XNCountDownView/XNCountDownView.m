//
//  XNCountDownView.m
//  CountdownDemo
//
//  Created by Luigi on 2019/6/13.
//  Copyright © 2019 Luigi. All rights reserved.
//

#import "XNCountDownView.h"

static CGFloat const labelInset = 5.f;//Label距离View边距
static CGFloat const textInset = 4.f;//文字距离Label边距
static CGFloat const colonInset = 3.f;//冒号距离两边Label间距

@interface XNCountDownView ()
@property (nonatomic, strong) UIView  *hourView;
@property (nonatomic, strong) UIView  *minuteView;
@property (nonatomic, strong) UIView  *secondView;

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@property (nonatomic, strong) UILabel *separatorLabel1;
@property (nonatomic, strong) UILabel *separatorLabel2;

@end


@implementation XNCountDownView

- (instancetype)initWithFont:(UIFont *)font TextColor:(UIColor *)textColor TextBackgroundColor:(UIColor *)textBackgroundColor ViewBackgroundColor:(UIColor *)viewBackgroundColor{
    if (self = [super init]) {
        self.backgroundColor = viewBackgroundColor;
        [self createUIWithFont:font TextColor:textColor BackgroundColor:textBackgroundColor];
    }
    return self;
}

- (instancetype)initWithFont:(UIFont *)font TextColor:(UIColor *)textColor ViewBackgroundColor:(UIColor *)viewBackgroundColor GradientDirection:(GradientDirection)direction BeginColor:(UIColor *)bColor EndColor:(UIColor *)eColor{
    if (self = [super init]) {
        self.backgroundColor = viewBackgroundColor;
        [self createUIWithFont:font TextColor:textColor BackgroundColor:[UIColor clearColor]];
        [self createGradientLayerWithGradientDirection:direction BeginColor:bColor EndColor:eColor];
    }
    return self;
}

#pragma mark - SetData
- (void)setCountTime:(NSTimeInterval)countTime{
    _countTime = countTime;
    if (countTime > 0) {
        [self refreshDataWithTimeInterval:countTime];
        [self openCountdownWithTime:countTime];
    }
}

- (void)setDeadline:(NSDate *)deadline{
    _deadline = deadline;
    if ([deadline isInFuture]) {
        NSTimeInterval timeInterval = [[NSDate date] secondsBeforeDate:deadline];
        [self refreshDataWithTimeInterval:timeInterval];
        [self openCountdownWithTime:timeInterval];
    }
}

- (void)refreshDataWithTimeInterval:(NSTimeInterval)timeInterval{
    NSInteger hours = (int)(timeInterval/3600);
    NSInteger minutes = (int)(timeInterval-hours*3600)/60;
    NSInteger seconds = (int)(timeInterval - hours*3600 - minutes*60);
    
    self.hourLabel.text = [NSString stringWithFormat:@"%@%ld",hours>9?@"":@"0",(long)hours];
    self.minuteLabel.text = [NSString stringWithFormat:@"%@%ld",minutes>9?@"":@"0",(long)minutes];
    self.secondLabel.text = [NSString stringWithFormat:@"%@%ld",seconds>9?@"":@"0",(long)seconds];
    [self refreshLayout];
}

#pragma mark - Action
// 开启倒计时效果
- (void)openCountdownWithTime:(int)delaytime{
    __block int time      = delaytime; //倒计时时间
    dispatch_queue_t queue   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            [self calculateHourMinuteAndSecondWithTimeInterval:time];
        }else{
            [self calculateHourMinuteAndSecondWithTimeInterval:time];
            time--;
        }
    });
    dispatch_resume(_timer);
}

//计算时分秒,并判断是否需要刷新布局
- (void)calculateHourMinuteAndSecondWithTimeInterval:(NSTimeInterval)timeInterval{
    
    NSInteger hours = (int)(timeInterval/3600);
    NSInteger minutes = (int)(timeInterval-hours*3600)/60;
    NSInteger seconds = (int)(timeInterval - hours*3600 - minutes*60);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        NSString *lastHourText = self.hourLabel.text;
        
        self.hourLabel.text = [NSString stringWithFormat:@"%@%ld",hours>9?@"":@"0",(long)hours];
        self.minuteLabel.text = [NSString stringWithFormat:@"%@%ld",minutes>9?@"":@"0",(long)minutes];
        self.secondLabel.text = [NSString stringWithFormat:@"%@%ld",seconds>9?@"":@"0",(long)seconds];
        
        if (lastHourText.length != self.hourLabel.text.length) {
            [self refreshLayout];
        }
    }];
    
}

#pragma mark - LayoutUI
- (void)createGradientLayerWithGradientDirection:(GradientDirection)direction BeginColor:(UIColor *)bColor EndColor:(UIColor *)eColor{
    CALayer *hourGradientLayer = [CALayer GradientLayerWithBounds:CGRectMake(0, 0, self.hourLabel.width+textInset*2, self.hourLabel.height+textInset*2) ColorArray:@[bColor,eColor] LocationArray:@[@(0),@(1)] GradientDirection:direction];
    hourGradientLayer.name = @"hourGradientLayer";
    [self.hourView.layer addSublayer:hourGradientLayer];
    [self.hourView bringSubviewToFront:self.hourLabel];
    
    CALayer *minuteGradientLayer = [CALayer GradientLayerWithBounds:CGRectMake(0, 0, self.minuteLabel.width+textInset*2, self.minuteLabel.height+textInset*2) ColorArray:@[bColor,eColor] LocationArray:@[@(0),@(1)] GradientDirection:direction];
    [self.minuteView.layer addSublayer:minuteGradientLayer];
    [self.minuteView bringSubviewToFront:self.minuteLabel];

    CALayer *secondGradientLayer = [CALayer GradientLayerWithBounds:CGRectMake(0, 0, self.secondLabel.width+textInset*2, self.secondLabel.height+textInset*2) ColorArray:@[bColor,eColor] LocationArray:@[@(0),@(1)] GradientDirection:direction];
    [self.secondView.layer addSublayer:secondGradientLayer];
    [self.secondView bringSubviewToFront:self.secondLabel];

}

- (void)createUIWithFont:(UIFont *)font TextColor:(UIColor *)textColor BackgroundColor:(UIColor *)backgroundColor{
    self.hourView = [UIView new];
    self.hourView.backgroundColor = backgroundColor;
    self.hourView.layer.cornerRadius = 2.f;
    self.hourView.layer.masksToBounds = YES;
    
    self.minuteView = [UIView new];
    self.minuteView.backgroundColor = backgroundColor;
    self.minuteView.layer.cornerRadius = 2.f;
    self.minuteView.layer.masksToBounds = YES;
    
    self.secondView = [UIView new];
    self.secondView.backgroundColor = backgroundColor;
    self.secondView.layer.cornerRadius = 2.f;
    self.secondView.layer.masksToBounds = YES;
    
    self.hourLabel = [UILabel initWithText:@"00" TextColor:textColor Font:font BackgroundColor:backgroundColor TextAlignment:NSTextAlignmentCenter];
    
    self.minuteLabel = [UILabel initWithText:@"00" TextColor:textColor Font:font BackgroundColor:backgroundColor TextAlignment:NSTextAlignmentCenter];
    
    self.secondLabel = [UILabel initWithText:@"00" TextColor:textColor Font:font BackgroundColor:backgroundColor TextAlignment:NSTextAlignmentCenter];
    
    self.separatorLabel1 = [UILabel initWithText:@":" TextColor:COLOR_BLACK_2C Font:font BackgroundColor:[UIColor clearColor] TextAlignment:NSTextAlignmentCenter];
    
    self.separatorLabel2 = [UILabel initWithText:@":" TextColor:COLOR_BLACK_2C Font:font BackgroundColor:[UIColor clearColor] TextAlignment:NSTextAlignmentCenter];
    
    [self layoutUI];
}

- (void)layoutUI{
    [self addSubview:self.hourView];
    [self.hourView addSubview:self.hourLabel];
    [self addSubview:self.separatorLabel1];
    [self addSubview:self.minuteView];
    [self.minuteView addSubview:self.minuteLabel];
    [self addSubview:self.separatorLabel2];
    [self addSubview:self.secondView];
    [self.secondView addSubview:self.secondLabel];
    
    [self.hourLabel sizeToFit];
    [self.minuteLabel sizeToFit];
    [self.secondLabel sizeToFit];
    [self.separatorLabel1 sizeToFit];
    [self.separatorLabel2 sizeToFit];
    
    [self layoutIfNeeded];
    
    CGFloat width,height;
    width = labelInset+textInset*2+self.hourLabel.width+colonInset*2+self.separatorLabel1.width+textInset*2+self.minuteLabel.width+colonInset*2+self.separatorLabel2.width+textInset*2+self.secondLabel.width+labelInset;
    height = labelInset*2 + textInset*2 + self.hourLabel.height;
    self.viewSize = CGSizeMake(width, height);
    
    [self.hourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(labelInset);
        make.left.offset(labelInset);
        make.width.offset(textInset*2+self.hourLabel.width);
        make.height.offset(textInset*2+self.hourLabel.height);
    }];
    
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.hourView);
    }];
    
    [self.separatorLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.hourView);
        make.left.equalTo(self.hourView.mas_right).offset(colonInset);
        make.width.offset(self.separatorLabel1.width);
    }];
    
    [self.minuteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.hourView);
        make.left.equalTo(self.separatorLabel1.mas_right).offset(colonInset);
        make.width.offset(textInset*2+self.minuteLabel.width);
    }];
    
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.minuteView);
    }];
    
    [self.separatorLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(self.separatorLabel1);
        make.left.equalTo(self.minuteView.mas_right).offset(colonInset);
    }];
    
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.minuteView);
        make.left.equalTo(self.separatorLabel2.mas_right).offset(colonInset);
        make.width.offset(textInset*2+self.secondLabel.width);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.height.equalTo(self.secondView);
    }];

    [self setNeedsUpdateConstraints];
}

- (void)refreshLayout{
    [self.hourLabel sizeToFit];
    
    [self.hourView.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.name) {
            if ([obj.name isEqualToString:@"hourGradientLayer"]) {
                obj.frame = CGRectMake(0, 0, self.hourLabel.width+textInset*2, self.hourLabel.height+textInset*2);
                *stop = YES;
            }
        }
    }];
    
    CGFloat width,height;
    width = labelInset+textInset*2+self.hourLabel.width+colonInset*2+self.separatorLabel1.width+textInset*2+self.minuteLabel.width+colonInset*2+self.separatorLabel2.width+textInset*2+self.secondLabel.width+labelInset;
    height = labelInset*2 + textInset*2 + self.hourLabel.height;
    self.viewSize = CGSizeMake(width, height);
    [self updateConstraints];
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.hourView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(textInset*2+self.hourLabel.width);
    }];
    
    self.hourLabel.frame = CGRectMake(0, 0, textInset*2+self.hourLabel.width, textInset*2+self.hourLabel.height);
    
}



@end
