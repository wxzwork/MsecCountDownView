//
//  ViewController.m
//  毫秒倒计时
//
//  Created by WOSHIPM on 17/1/11.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import "ViewController.h"
#import "MsecCountDownView.h"
@interface ViewController ()
{
    MsecCountDownView *msecView;
    https://github.com/wxzwork/MsecCountDownView.git
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    msecView=[[MsecCountDownView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width-100, 16)];
    [self.view addSubview:msecView];
 
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
 
 
    NSDate* date = [formatter dateFromString:@"2017-04-11 15:10:00.000"];
    //将日期转换成时间戳
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue]*1000;
    msecView.timeInterval=timeSp;
 
}
-(void)viewWillAppear:(BOOL)animated{
 
//    页面消失时，暂停提示器
    [msecView.timer setFireDate:[NSDate distantPast]];
    
}
-(void)viewWillDisappear:(BOOL)animated{
//    页面出现时，计时器开始
    [msecView.timer setFireDate:[NSDate distantFuture]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   /**
    iOS毫秒倒计时的实现
    app开发中，当展示限时优惠的某些商品时，往往会加一个倒计时，提示用户该商品限时优惠所剩的时间，。那对于开发者来说，这就需要我们去实现的是一个倒计时的功能，这个倒计时根据具体需求，可以以天、小时、分、秒、毫秒作单位。
    今天呢，主要说说毫秒计时器。我们知道秒和毫秒之间的进制是1000，也就是说1秒=1000毫秒，那我们做毫秒倒计时器的时候是设置一个时间间隔为1毫秒的计时器，逐一减少毫秒数。但是这样的话太耗时了，所以很多的毫秒计时器中的毫秒数只是0-9之间的数字，这就意味着，这个毫秒计时器的时间间隔是100毫秒，这样相比起1毫秒为间隔的计时器，其消耗就少了很多，同时也达到毫秒计时的效果。
    那对于整个毫秒倒计时的实现思路就是：得到未来某个日期的时间戳和当前日期的时间戳，计算这两者之间的时间差，然后设置一个时间间隔为100毫秒的计时器，每隔100毫秒，更新一下倒计时器上相应的数值。
    自定义一个UIview，将倒计时封装起来。
    
    
    
    */
}


@end
