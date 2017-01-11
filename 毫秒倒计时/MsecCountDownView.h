//
//  MsecCountDownView.h
//  毫秒倒计时
//
//  Created by WOSHIPM on 17/1/11.
//  Copyright © 2017年 WOSHIPM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MsecCountDownView : UIView
 
@property(nonatomic, assign)double timeInterval;
@property(nonatomic, strong)NSTimer *timer ; //定时器
 
@end
