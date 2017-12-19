//
//  ZZPayTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZPayTool.h"

@implementation ZZPayTool

+(UIAlertController*)testPayingAlertController
{
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"test pay" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"alipay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self testGotoAlipay];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"wechatpay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self testGotoWechatpay];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"unionpay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self testGotoUnionpay];
    }]];
    return alert;
}

+(void)testGotoAlipay
{
    [[AlipaySDK defaultService]payOrder:@"123123" fromScheme:@"com.bangju.zhanmao" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
    }];
}

+(void)testGotoWechatpay
{
//    PayReq *request = [[PayReq alloc] init];
//    request.partnerId = @"1";
//    request.prepayId= @"1";
//    request.package = @"Sign=WXPay";
//    request.nonceStr= @"123";
//    request.timeStamp= [[NSDate date]timeIntervalSince1970];
//    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
//    [WXApi sendReq:request];
}

+(void)testGotoUnionpay
{
    
}

+(void)payWithAlipayString:(NSString *)string
{
    [[AlipaySDK defaultService]payOrder:string fromScheme:@"com.bangju.zhanmao" callback:^(NSDictionary *resultDic) {
        NSLog(@"%@",resultDic);
        
//        [MBProgressHUD showSuccessMessage:resultDic.description];
        [self handleAlipayResult:resultDic];
    }];
}

+(void)handleAlipayResult:(NSDictionary *)result
{
    /*
     9000 订单支付成功
     8000 正在处理中
     4000 订单支付失败
     6001 用户中途取消
     6002 网络连接出错*/
    
    NSInteger resultStatus=[[result valueForKey:@"resultStatus"]integerValue];

    NSInteger resul=PayResultTypeFailure;
    if (resultStatus==9000) {
        resul=PayResultTypeSuccess;
    }
    else if(resultStatus==8000)
    {
        resul=PayResultTypeUnknown;
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:ZZPayToolReceviedPayResultNotification object:nil userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:resul] forKey:@"result"]];
}

@end
