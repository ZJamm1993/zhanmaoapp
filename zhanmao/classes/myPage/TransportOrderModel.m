//
//  TransportOrderModel.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TransportOrderModel.h"

@implementation TransportOrderModel

+(NSString*)controllerTitleForType:(NSInteger)type
{
    if (type==TransportOrderTypeNow) {
        return @"当前订单";
    }
    else if(type==TransportOrderTypeHistory)
    {
        return @"历史订单";
    }
    return @"";
}

@end
