//
//  ZZPayTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
//#import "WXApi.h"

typedef NS_ENUM(NSInteger,PayResultType)
{
    PayResultTypeUnknown,
    PayResultTypeSuccess,
    PayResultTypeFailure,
};

//#define AlipayDidPaySuccessNotification @"AlipayDidPaySuccessNotification"
//#define WechatpayDidPaySuccessNotification @"WechatpayDidPaySuccessNotification"
//#define UnionpayDidPaySuccessNotification @"UnionpayDidPaySuccessNotification"

#define ZZPayToolReceviedPayResultNotification @"ZZPayToolReceviedPayResultNotification"

@interface ZZPayTool : NSObject

+(UIAlertController*)testPayingAlertController;

+(void)testGotoAlipay;
+(void)testGotoWechatpay;
+(void)testGotoUnionpay;

+(void)payWithAlipayString:(NSString*)string;
+(void)handleAlipayResult:(NSDictionary*)result;

@end
