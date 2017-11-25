//
//  ZZPayTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

#define AlipayDidPaySuccessNotification @"AlipayDidPaySuccessNotification"
#define WechatpayDidPaySuccessNotification @"WechatpayDidPaySuccessNotification"
#define UnionpayDidPaySuccessNotification @"UnionpayDidPaySuccessNotification"

@interface ZZPayTool : NSObject

+(UIAlertController*)testPayingAlertController;

+(void)testGotoAlipay;
+(void)testGotoWechatpay;
+(void)testGotoUnionpay;

@end
