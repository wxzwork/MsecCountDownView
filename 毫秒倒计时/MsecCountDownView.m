//
//  MsecCountDownView.m
//  毫秒倒计时
//
//  Created by WOSHIPM on 17/1/11.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "MsecCountDownView.h"

@interface MsecCountDownView (){
UIView *countdownBackView;
CGFloat _passTime;
}
@property(nonatomic, strong)UILabel *tipLabel;
@property(nonatomic, strong)UILabel *hoursLabel;
@property(nonatomic, strong)UILabel *minutesLabel;
@property(nonatomic, strong)UILabel *secondsLabel;
@property(nonatomic, strong)UILabel *millionSecondsLabel;
@property(nonatomic, strong)UILabel *label1;
@property(nonatomic, strong)UILabel *label2;
@property(nonatomic, strong)UILabel *label3;
@property(nonatomic, strong)UILabel *label4;
@end

@implementation MsecCountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        countdownBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:countdownBackView];
        _tipLabel=[[UILabel alloc] init];
        _tipLabel.frame = CGRectMake(0, 0, 40, countdownBackView.frame.size.height);
        [countdownBackView addSubview:_tipLabel];
     
        _tipLabel.font = [UIFont systemFontOfSize:12];
        
        
        //小时
        _hoursLabel=[[UILabel alloc] initWithFrame:CGRectMake(_tipLabel.frame.origin.x+_tipLabel.frame.size.width, 0, 35, countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_hoursLabel];
        _hoursLabel.font = [UIFont systemFontOfSize:11];
        
        _label1=[[UILabel alloc] initWithFrame:CGRectMake(_hoursLabel.frame.origin.x+_hoursLabel.frame.size.width, _hoursLabel.frame.origin.y, 8, countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_label1];
        
        //分钟
        _minutesLabel=[[UILabel alloc] initWithFrame:CGRectMake(_label1.frame.origin.x+_label1.frame.size.width,  _hoursLabel.frame.origin.y, 20, countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_minutesLabel];
        _minutesLabel.font = [UIFont systemFontOfSize:11];
        
        _label2=[[UILabel alloc] initWithFrame:CGRectMake(_minutesLabel.frame.origin.x+_minutesLabel.frame.size.width,  _hoursLabel.frame.origin.y, 8, countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_label2];
        
      //秒
        _secondsLabel=[[UILabel alloc] initWithFrame:CGRectMake(_label2.frame.origin.x+_label2.frame.size.width,  _hoursLabel.frame.origin.y, 20 , countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_secondsLabel];
 
        
        _secondsLabel.font = [UIFont systemFontOfSize:11];
        
        _label3=[[UILabel alloc] initWithFrame:CGRectMake(_secondsLabel.frame.origin.x+_secondsLabel.frame.size.width,  _hoursLabel.frame.origin.y, 8 , countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_label3];
        
        
        _millionSecondsLabel=[[UILabel alloc] initWithFrame:CGRectMake(_label3.frame.origin.x+_label3.frame.size.width,  _hoursLabel.frame.origin.y, 20, countdownBackView.frame.size.height)];
        [countdownBackView addSubview:_millionSecondsLabel];
        
        
           //毫秒
        
        _millionSecondsLabel.font = [UIFont systemFontOfSize:11];
        
        _label1.textAlignment=1;
        _label2.textAlignment=1;
        _label3.textAlignment = 1;
        _hoursLabel.textAlignment=1;
        _minutesLabel.textAlignment=1;
        _secondsLabel.textAlignment=1;
        _millionSecondsLabel.textAlignment=1;
 
        
        _passTime=0.0;
    }
    
    
    return self;
}

//得到未来某个日期的时间戳，与当前时间戳相比，得到两者的时间差，生成定时器
- (void)setTimeInterval:(double)timeInterval
{
 
    _timeInterval = timeInterval ;
 
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"MM/dd/yyyy HH:mm:ss.SSS";
    
    //获取当前系统的时间，并用相应的格式转换
    [dataFormatter stringFromDate:[NSDate date]];
    NSString *currentDayStr = [dataFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dataFormatter dateFromString:currentDayStr];
    
    //优惠结束的时间，也用相同的格式去转换
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000.0];
    NSString *deadlineStr = [dataFormatter stringFromDate:date];
    NSDate *deadlineDate = [dataFormatter dateFromString:deadlineStr];
    
    _timeInterval=[deadlineDate timeIntervalSinceDate:currentDate]*1000;
    
    if (_timeInterval!=0)
    {
        
        //时间间隔是100毫秒，也就是0.1秒
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    }else{
        [countdownBackView removeFromSuperview];
        
    }
 
}


// 每间隔100毫秒定时器触发执行该方法
- (void)timerAction
{
   
    [self getTimeFromTimeInterval:_timeInterval] ;
    
   
    // 当时间间隔为0时干掉定时器
    if (_timeInterval-_passTime == 0)
    {
        [_timer invalidate] ;
        _timer = nil ;
    }
}

// 通过时间间隔计算具体时间(小时,分,秒,毫秒)
- (void)getTimeFromTimeInterval : (double)timeInterval
{

    //1s=1000毫秒
    _passTime += 100.f;//毫秒数从0-9，所以每次过去100毫秒
    _tipLabel.text=@"还剩：";
 
    _label3.text=@".";
    _label2.text=@":";
    _label1.text=@":";
    
    //小时数
    NSString *hours = [NSString stringWithFormat:@"%ld", (NSInteger)((timeInterval-_passTime)/1000/60/60)];
    //分钟数
    NSString *minute = [NSString stringWithFormat:@"%ld", (NSInteger)((timeInterval-_passTime)/1000/60)%60];
    //秒数
    NSString *second = [NSString stringWithFormat:@"%ld", ((NSInteger)(timeInterval-_passTime))/1000%60];
    //毫秒数
    CGFloat sss = ((NSInteger)((timeInterval - _passTime)))%1000/100;
    
    
    NSString *ss = [NSString stringWithFormat:@"%.lf", sss];
    
    if (minute.integerValue < 10) {
        minute = [NSString stringWithFormat:@"0%@", minute];
    }
    
 
    self.hoursLabel.text = [NSString stringWithFormat:@"%@",hours];
    self.minutesLabel.text = [NSString stringWithFormat:@"%@",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%@",second];
    self.millionSecondsLabel.text = [NSString stringWithFormat:@"%@",ss];
    
    if (timeInterval - _passTime <= 0) {
        [countdownBackView removeFromSuperview];
        [self removeFromSuperview];
    }
    
}

 
@end

