//
//  PayOrderModel.h
//  zhanmao
//
//  Created by jam on 2017/12/5.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZModel.h"

typedef NS_ENUM(NSInteger, PayMethodType)
{
    PayMethodTypeWechatPay=1,
    PayMethodTypeAlipay=2,
    PayMethodTypeUnionpay=3,
};

typedef NS_ENUM(NSInteger, PayStatus)
{
    PayStatusNotYet=0,
    PayStatusSuccess=1,
    PayStatusFailure=2,
    PayStatusExpired=3,
};

@interface PayOrderModel : ZZModel

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,assign) CGFloat amount;
@property (nonatomic,assign) CGFloat expiration;

@end
