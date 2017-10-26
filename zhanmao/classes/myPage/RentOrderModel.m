//
//  RentOrderModel.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentOrderModel.h"

@implementation RentOrderModel

+(NSString*)controllerTitleForType:(RentOrderType)type
{
    if (type==RentOrderTypeAll) {
        return @"全部";
    }
    else if (type==RentOrderTypeNotPaid) {
        return @"待付款";
    }
    else if (type==RentOrderTypeNotSigned) {
        return @"待收货";
    }
    else if (type==RentOrderTypeNotReturned) {
        return @"待归还";
    }
    else if (type==RentOrderTypeFinished) {
        return @"已完成";
    }
    return @"";
}

+(NSString*)cellTitleForType:(RentOrderType)type{
    if (type==RentOrderTypeNotPaid) {
        return @"待付款";
    }
    else if (type==RentOrderTypeNotSigned) {
        return @"待收货";
    }
    else if (type==RentOrderTypeNotReturned) {
        return @"待归还";
    }
    else if (type==RentOrderTypeFinished) {
        return @"交易成功";
    }
    return @"";
}

@end
