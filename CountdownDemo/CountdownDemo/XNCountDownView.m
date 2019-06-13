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

- (void)setCountTime:(NSTimeInterval)countTime{
    _countTime = countTime;
    [self openCountdownWithTime:countTime];
}

- (void)setDeadline:(NSDate *)deadline{
    _deadline = deadline;
    if ([deadline isInFuture]) {
        NSTimeInterval timeInterval = [[NSDate date] secondsAfterDate:deadline];
        [self openCountdownWithTime:timeInterval];
    }
}

- (void)calculateHourMinuteAndSecondWithTimeInterval:(NSTimeInterval)timeInterval{
    
    NSInteger hours = (int)(timeInterval/3600);
    NSInteger minutes = (int)(timeInterval-hours*3600)/60;
    NSInteger seconds = (int)(timeInterval - hours*3600 - minutes*60);
    
    NSString *lastHourText = self.hourLabel.text;
    
    self.hourLabel.text = [NSString stringWithFormat:@"%@%ld",hours>9?@"":@"0",(long)hours];
    self.minuteLabel.text = [NSString stringWithFormat:@"%@%ld",minutes>9?@"":@"0",(long)minutes];
    self.secondLabel.text = [NSString stringWithFormat:@"%@%ld",seconds>9?@"":@"0",(long)seconds];

    if (lastHourText.length != self.hourLabel.text.length) {
        [self refreshLayout];
    }
    
}

- (void)createUIWithFont:(UIFont *)font TextColor:(UIColor *)textColor BackgroundColor:(UIColor *)backgroundColor{
    self.hourLabel = [UILabel initWithText:@"00" TextColor:textColor Font:font BackgroundColor:backgroundColor TextAlignment:NSTextAlignmentCenter];
    self.hourLabel.layer.cornerRadius = 2.f;
    self.hourLabel.layer.masksToBounds = YES;
    
    self.minuteLabel = [UILabel initWithText:@"00" TextColor:textColor Font:font BackgroundColor:backgroundColor TextAlignment:NSTextAlignmentCenter];
    self.minuteLabel.layer.cornerRadius = 2.f;
    self.minuteLabel.layer.masksToBounds = YES;
    
    self.secondLabel = [UILabel initWithText:@"00" TextColor:textColor Font:font BackgroundColor:backgroundColor TextAlignment:NSTextAlignmentCenter];
    self.secondLabel.layer.cornerRadius = 2.f;
    self.secondLabel.layer.masksToBounds = YES;
    
    self.separatorLabel1 = [UILabel initWithText:@":" TextColor:COLOR_BLACK_2C Font:font BackgroundColor:[UIColor clearColor] TextAlignment:NSTextAlignmentCenter];
    self.separatorLabel2 = [UILabel initWithText:@":" TextColor:COLOR_BLACK_2C Font:font BackgroundColor:[UIColor clearColor] TextAlignment:NSTextAlignmentCenter];
    
    [self layoutUI];
}

- (void)layoutUI{
    [self addSubview:self.hourLabel];
    [self addSubview:self.separatorLabel1];
    [self addSubview:self.minuteLabel];
    [self addSubview:self.separatorLabel2];
    [self addSubview:self.secondLabel];
    
    [self.hourLabel sizeToFit];
    [self.minuteLabel sizeToFit];
    [self.secondLabel sizeToFit];
    [self.separatorLabel1 sizeToFit];
    [self.separatorLabel2 sizeToFit];
    
    CGFloat width,height;
    width = labelInset*2+self.hourLabel.width+self.minuteLabel.width+self.secondLabel.width+(colonInset*2+self.separatorLabel1.width)*2;
    height = labelInset*2 + textInset*2 + self.hourLabel.height;
    self.viewSize = CGSizeMake(width, height);
    
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(labelInset);
        make.left.offset(labelInset);
        make.width.offset(textInset*2+self.hourLabel.width);
        make.height.offset(textInset*2+self.hourLabel.height);
    }];
    
    [self.separatorLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.hourLabel);
        make.left.equalTo(self.hourLabel.mas_right).offset(colonInset);
        make.width.offset(self.separatorLabel1.width);
    }];
    
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.hourLabel);
        make.left.equalTo(self.separatorLabel1.mas_right).offset(colonInset);
        make.width.offset(textInset*2+self.minuteLabel.width);
    }];
    
    [self.separatorLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.width.equalTo(self.separatorLabel1);
        make.left.equalTo(self.minuteLabel.mas_right).offset(colonInset);
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.minuteLabel);
        make.left.equalTo(self.separatorLabel2.mas_right).offset(colonInset);
        make.width.offset(textInset*2+self.secondLabel.width);
    }];

    [self setNeedsUpdateConstraints];
}

- (void)refreshLayout{
    [self.hourLabel sizeToFit];
    
    CGFloat width,height;
    width = labelInset*2+self.hourLabel.width+self.minuteLabel.width+self.secondLabel.width+(colonInset*2+self.separatorLabel1.width)*2;
    height = labelInset*2 + textInset*2 + self.hourLabel.height;
    self.viewSize = CGSizeMake(width, height);
    
    [self updateConstraints];
}

- (void)updateConstraints{
    [super updateConstraints];
    
    [self.hourLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(textInset*2+self.hourLabel.width);
    }];
    
}

// 开启倒计时效果
- (void)openCountdownWithTime:(int)delaytime{
    __block int time      = delaytime; //倒计时时间
    dispatch_queue_t queue   = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self calculateHourMinuteAndSecondWithTimeInterval:time];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self calculateHourMinuteAndSecondWithTimeInterval:time];
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}



@end
