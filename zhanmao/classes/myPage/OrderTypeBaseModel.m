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

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _idd=[dictionary valueForKey:@"id"];
        _number=[dictionary valueForKey:@"number"];
        
        _status=[[dictionary valueForKey:@"status"]integerValue];
//        _pay_status=[dictionary valueForKey:@"pay_status"];
        
        _amount=[dictionary valueForKey:@"amount"];
        
        _pay_type=[dictionary valueForKey:@"pay_type"];
        
        _createtime=[dictionary valueForKey:@"createtime"];
        _paytime=[dictionary valueForKey:@"paytime"];
        _delivery_date=[dictionary valueForKey:@"delivery"];
    }
    return self;
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
    if (type==RentOrderStatusNotPaid) {
        return @"待付款";
    }
    else if (type==RentOrderStatusNotSigned) {
        return @"待收货";
    }
    else if (type==RentOrderStatusProcessing) {
        return @"使用中";
    }
    else if (type==RentOrderStatusNotReturned) {
        return @"待归还";
    }
    else if (type==RentOrderStatusFinished) {
        return @"交易成功";
    }
    else if (type==RentOrderStatusDeleted)
    {
        
    }
    return @"";
}

+(NSString*)cellButtonTitleForType:(NSInteger)type
{
    NSString* buttonTitle=@"";
    if (type==RentOrderStatusFinished) {
        buttonTitle=@"关闭交易";
    }
    else if (type==RentOrderStatusNotPaid) {
        buttonTitle=@"立即付款";
    }
    else if (type==RentOrderStatusNotSigned) {
        buttonTitle=@"确认收货";
    }
    else if (type==RentOrderStatusNotReturned) {
        buttonTitle=@"确认归还";
    }
    else if (type==RentOrderStatusFinished) {
        buttonTitle=@"关闭交易";
    }
    return buttonTitle;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        //the "pay uses the same dictionary
        self.pay=[[PayOrderModel alloc]initWithDictionary:dictionary];
        
        // the "address" uses the same dictionary
        self.address=[[AddressModel alloc]initWithDictionary:dictionary];
    
        NSMutableArray* goods_muta=[NSMutableArray array];
        NSArray* goos=[dictionary valueForKey:@"goods"];
        for (NSDictionary* go in goos) {
            RentCartModel* cart=[[RentCartModel alloc]initWithDictionary:go];
            [goods_muta addObject:cart];
        }
        self.goods=goods_muta;
    }
    return self;
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
//    else if(type==CleanOrderTypeProceeding)
//    {
//        return @"处理中";
//    }
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
//    else if(type==CleanOrderTypeProceeding)
//    {
//        return @"处理中";
//    }
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

@implementation CustomOrderModel

+(NSString*)controllerTitleForType:(NSInteger)type
{
    if (type==CustomOrderTypeNow) {
        return @"当前订单";
    }
    else if(type==CustomOrderTypeHistory)
    {
        return @"历史订单";
    }
    return @"";
}

@end


