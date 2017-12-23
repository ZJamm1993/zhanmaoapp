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

+(NSString*)detailHeaderTitleForType:(NSInteger)type
{
    return @"";
}

+(NSString*)detailHeaderDescritionForType:(NSInteger)type
{
    return @"";
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _idd=[dictionary valueForKey:@"id"];
        _number=[dictionary valueForKey:@"number"];
        _order_num=[dictionary valueForKey:@"order_num"];
//        _status=[[dictionary valueForKey:@"status"]integerValue];
        _order_status=[[dictionary valueForKey:@"order_status"]integerValue];
        _pay_status=[[dictionary valueForKey:@"pay_status"]integerValue];
        
        _amount=[[dictionary valueForKey:@"amount"]doubleValue];
        _expiration=[[dictionary valueForKey:@"expiration"]doubleValue];
        
        _pay_type=[dictionary valueForKey:@"pay_type"];
        
        _createtime=[dictionary valueForKey:@"createtime"];
        _paytime=[dictionary valueForKey:@"paytime"];
        
        _post_modified=[dictionary valueForKey:@"post_modified"];
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
    if (type==RentOrderStatusNotSent) {
        return @"待发货";
    }
    else if (type==RentOrderStatusNotReceived) {
        return @"待收货";
    }
    else if (type==RentOrderStatusNotReturn) {
        return @"待归还";
    }
    else if (type==RentOrderStatusReturning) {
        return @"已回收";
    }
    else if (type==RentOrderStatusFinishing||type==RentOrderStatusFinished) {
        return @"已完成";
    }
    else if(type==RentOrderStatusCanceled)
    {
        return @"已取消";
    }
    return @"未知";
}
//
+(NSString*)cellButtonTitleForType:(NSInteger)type
{
    NSString* buttonTitle=@"未知";
    if (type==RentOrderStatusNotSent) {
        buttonTitle=@"确认收货";
    }
    else if (type==RentOrderStatusNotReceived) {
        buttonTitle=@"确认收货";
    }
    else if (type==RentOrderStatusNotReturn) {
        buttonTitle=@"待归还";
    }
    else if (type==RentOrderStatusReturning) {
        buttonTitle=@"归还中";
    }
    else if (type==RentOrderStatusFinishing||type==RentOrderStatusFinished) {
        buttonTitle=@"已完成";
    }
    else if(type==RentOrderStatusCanceled)
    {
        return @"已取消";
    }
    return buttonTitle;
}

+(NSString*)detailHeaderTitleForType:(NSInteger)type
{
    if (type==RentOrderStatusNotSent) {
        return @"等待收货";
    }
    else if (type==RentOrderStatusNotReceived) {
        return @"等待收货";
    }
    else if (type==RentOrderStatusNotReturn) {
        return @"商品等待归还";
    }
    else if (type==RentOrderStatusReturning) {
        return @"商品归还中";
    }
    else if (type==RentOrderStatusFinishing||type==RentOrderStatusFinished) {
        return @"订单已完成";
    }else if(type==RentOrderStatusCanceled)
    {
        return @"已取消";
    }
    return @"未知状态";
}
//
+(NSString*)detailHeaderDescritionForType:(NSInteger)type
{
    if (type==RentOrderStatusNotSent) {
        return @"订单已处理，请耐心等待";
    }
    else if (type==RentOrderStatusNotReceived) {
        return @"订单已处理，请耐心等待";
    }
    else if (type==RentOrderStatusNotReturn||type==RentOrderStatusReturning) {
        return @"我们将安排工作人员上门回收租赁商品";
    }
    else if (type==RentOrderStatusFinishing) {
        return @"押金已原路退回，请注意查收";//押金会在一周内原路返回，请注意查收";
    }
    else if(type==RentOrderStatusFinished)
    {
        return @"押金已原路退回，请注意查收";
    }else if(type==RentOrderStatusCanceled)
    {
        return @"已取消";
    }
    return @"";
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.leaseperiod=[[dictionary valueForKey:@"leaseperiod"]integerValue];
        self.order_status=[[dictionary valueForKey:@"status"]integerValue];
        self.delivery_date=[dictionary valueForKey:@"delivery_date"];
        self.return_date=[dictionary valueForKey:@"return_date"];
        self.recover_date=[dictionary valueForKey:@"recover_date"];
        self.emergency_phone=[dictionary valueForKey:@"emergency_phone"];
        
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

+(NSString*)detailHeaderTitleForType:(NSInteger)type
{
    NSString* headerTitle=@"订单已取消";
    if (type==TransportOrderStatusSubmited) {
        headerTitle=@"订单已提交";
    }
    else if (type==TransportOrderStatusCompleted) {
        headerTitle=@"订单已完成";
    }
    return headerTitle;
}

+(NSString*)detailHeaderDescritionForType:(NSInteger)type
{
    NSString* headerDetail=@"您的订单已取消";
    if (type==TransportOrderStatusSubmited) {
        headerDetail=@"请等待快递员上门取件";
    }
    else if (type==TransportOrderStatusCompleted) {
        headerDetail=@"您的订单已完成";
    }
    return headerDetail;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _logistics_type=[dictionary valueForKey:@"logistics_type"];
        _sender=[dictionary valueForKey:@"sender"];
        _collect=[dictionary valueForKey:@"collect"];
        
        _send_date=[dictionary valueForKey:@"send_date"];
        _item_type=[dictionary valueForKey:@"item_type"];
        _volume=[dictionary valueForKey:@"volume"];
        _professor=[dictionary valueForKey:@"professor"];
        _evaluate=[dictionary valueForKey:@"evaluate"];
        _sender_addr=[dictionary valueForKey:@"sender_addr"];
        _collect_addr=[dictionary valueForKey:@"collect_addr"];
    }
    return self;
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
        return @"已付款";
    }
    else if(type==CleanOrderTypeFinished)
    {
        return @"已完成";
    }
    return @"";
}

+(NSString*)cellStateForType:(NSInteger)type
{
    if(type==CleanOrderStatusNotClean)
    {
        return @"已付款";
    }
    else if(type==CleanOrderStatusCleaned)
    {
        return @"已付款";
    }
    else if(type==CleanOrderStatusFinished)
    {
        return @"已完成";
    }
    return @"";
}

+(NSString*)cellButtonTitleForType:(NSInteger)type
{
//    if(type==CleanOrderStatusNotPaid)
//    {
//        return @"立即付款";
//    }
    return @"查看详情";
}

+(NSString*)detailHeaderTitleForType:(NSInteger)type
{
    if (type==CleanOrderStatusNotClean) {
        return @"订单已付款";
    }
    else if(type==CleanOrderStatusCleaned||type==CleanOrderStatusFinished)
    {
        return @"订单已完成";
    }
    return @"订单已取消";
}

+(NSString*)detailHeaderDescritionForType:(NSInteger)type
{
    if (type==CleanOrderStatusNotClean) {
        return @"您的订单付款成功";
    }
    else if(type==CleanOrderStatusCleaned||type==CleanOrderStatusFinished)
    {
        return @"您的订单已经完成";
    }
    return @"";
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _other=[[dictionary valueForKey:@"other"]doubleValue];
        _professor=[[dictionary valueForKey:@"professor"]doubleValue];
        
        _cost=[[dictionary valueForKey:@"cost"]doubleValue];
        _other_cost=[[dictionary valueForKey:@"other_cost"]doubleValue];
        
        self.order_status=[[dictionary valueForKey:@"status"]integerValue];
        
        _addressee=[dictionary valueForKey:@"addressee"];
        _m_phone=[dictionary valueForKey:@"m_phone"];
        _date=[dictionary valueForKey:@"date"];
        _addr=[dictionary valueForKey:@"addr"];
        
        //the "pay uses the same dictionary
        self.pay=[[PayOrderModel alloc]initWithDictionary:dictionary];
    
    }
    return self;
}

@end

@implementation CustomOrderModel

+(NSString*)controllerTitleForType:(NSInteger)type
{
    if (type==CustomOrderTypeZhuchang) {
        return @"主场";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        return @"展台";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        return @"展厅";
    }
    else if(type==CustomOrderTypeWutai)
    {
        return @"舞台";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        return @"演艺";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        return @"邀约";
    }
    return @"";
}

+(NSString*)cellOrderTypeNameForType:(NSInteger)type
{
    if (type==CustomOrderTypeZhuchang) {
        return @"";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        return @"展会名称：";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        return @"项目名称：";
    }
    else if(type==CustomOrderTypeWutai)
    {
        return @"活动名称：";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        return @"活动名称：";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        return @"展会名称：";
    }
    return @"";
}

+(NSString*)cellOrderIdNameForType:(NSInteger)type
{
    return @"定制单号";
}

+(NSString*)cellOrderDateNameForType:(NSInteger)type
{
    if (type==CustomOrderTypeZhuchang) {
        return @"展会日期";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        return @"展位日期";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        return @"竣工日期";
    }
    else if(type==CustomOrderTypeWutai)
    {
        return @"活动日期";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        return @"活动日期";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        return @"展会日期";
    }
    return @"";
}

+(NSString*)cellOrderUnitNameForType:(NSInteger)type
{
    if (type==CustomOrderTypeZhuchang) {
        return @"承办单位";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        return @"参展单位";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        return @"设计单位";
    }
    else if(type==CustomOrderTypeWutai)
    {
        return @"承办单位";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        return @"承办单位";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        return @"承办单位";
    }
    return @"";
}

@end


