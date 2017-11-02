//
//  OrderTypeBaseModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeBaseModel.h"

@implementation OrderTypeBaseModel

+(NSString*)controllerTitleForType:(NSInteger)type
{
    return @"";
}

+(NSString*)cellStateForType:(NSInteger)type
{
    return @"";
}

+(NSString*)cellButtonTitleForType:(NSInteger)type
{
    return @"";
}

@end

@implementation RentOrderModel

+(NSString*)controllerTitleForType:(NSInteger)type
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

+(NSString*)cellStateForType:(NSInteger)type{
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

+(NSString*)cellButtonTitleForType:(NSInteger)type
{
    NSString* buttonTitle=@"";
    if (type==RentOrderTypeFinished) {
        buttonTitle=@"关闭交易";
    }
    else if (type==RentOrderTypeNotPaid) {
        buttonTitle=@"立即付款";
    }
    else if (type==RentOrderTypeNotSigned) {
        buttonTitle=@"确认收货";
    }
    else if (type==RentOrderTypeNotReturned) {
        buttonTitle=@"确认归还";
    }
    return buttonTitle;
}

@end

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

@implementation CleanOrderModel

+(NSString*)controllerTitleForType:(NSInteger)type
{
    if(type==CleanOrderTypeAll)
    {
        return @"全部";
    }
    else if(type==CleanOrderTypeNotPaid)
    {
        return @"待付款";
    }
    else if(type==CleanOrderTypeProceeding)
    {
        return @"处理中";
    }
    else if(type==CleanOrderTypeFinished)
    {
        return @"已完成";
    }
    return @"";
}

+(NSString*)cellStateForType:(NSInteger)type
{
    if(type==CleanOrderTypeNotPaid)
    {
        return @"待付款";
    }
    else if(type==CleanOrderTypeProceeding)
    {
        return @"处理中";
    }
    else if(type==CleanOrderTypeFinished)
    {
        return @"已完成";
    }
    return @"";
}

+(NSString*)cellButtonTitleForType:(NSInteger)type
{
    if(type==CleanOrderTypeNotPaid)
    {
        return @"立即付款";
    }
    return @"查看详情";
}

@end


