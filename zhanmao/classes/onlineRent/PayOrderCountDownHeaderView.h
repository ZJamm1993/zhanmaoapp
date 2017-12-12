//
//  PayOrderCountDownHeaderView.h
//  zhanmao
//
//  Created by jam on 2017/12/5.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayOrderCountDownHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *timeLabal;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic,assign) CGFloat expiration;
@property (nonatomic,assign) CGFloat totalTime;
@property (nonatomic,assign) CGFloat leftTime;

@end
