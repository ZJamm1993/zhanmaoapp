//
//  OrderTypeDataSource.m
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "OrderTypeDataSource.h"

@implementation OrderTypeDataSource

+(void)getMyRentOrderByType:(NSInteger)type token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Order/getlist"];
    
    NSMutableDictionary* dic=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [dic setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* ddd in list) {
            RentOrderModel* ro=[[RentOrderModel alloc]initWithDictionary:ddd];
            [result addObject:ro];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
    
}

+(void)getMyRentOrderDetailById:(NSString *)idd token:(NSString *)token success:(void (^)(RentOrderModel *))success
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Order/show"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:NO success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        RentOrderModel* mo=[[RentOrderModel alloc]initWithDictionary:data];
        if (success) {
            success(mo);
        }
    } failure:^(NSError *err) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)postMyRentOrderCancelById:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    if (token.length==0) {
        if (success) {
            success(NO,nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Order/del"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)postMyRentOrderReceiveById:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    if (token.length==0) {
        if (success) {
            success(NO,nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Order/comfirm"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)getMyTransportOrderByType:(NSInteger)type token:(NSString *)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/LogisticsOrder/getlist"];
    
    NSMutableDictionary* dic=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [dic setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* ddd in list) {
            TransportOrderModel* ro=[[TransportOrderModel alloc]initWithDictionary:ddd];
            [result addObject:ro];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getMyTransportOrderDetailById:(NSString *)idd token:(NSString *)token success:(void (^)(TransportOrderModel *))success
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/LogisticsOrder/show"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:NO success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        TransportOrderModel* mo=[[TransportOrderModel alloc]initWithDictionary:data];
        if (success) {
            success(mo);
        }
    } failure:^(NSError *err) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)postMyTransportOrderCancelById:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    if (token.length==0) {
        if (success) {
            success(NO,nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/LogisticsOrder/del"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)getMyCleanOrderByType:(NSInteger)type token:(NSString *)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/CleaningOrder/getlist"];
    
    NSMutableDictionary* dic=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [dic setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* ddd in list) {
            CleanOrderModel* ro=[[CleanOrderModel alloc]initWithDictionary:ddd];
            [result addObject:ro];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getMyCleanOrderDetailById:(NSString *)idd token:(NSString *)token success:(void (^)(CleanOrderModel *))success
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/CleaningOrder/show"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:NO success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        CleanOrderModel* mo=[[CleanOrderModel alloc]initWithDictionary:data];
        if (success) {
            success(mo);
        }
    } failure:^(NSError *err) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)postMyCleanOrderCancelById:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    if (token.length==0) {
        if (success) {
            success(NO,nil);
        }
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/CleaningOrder/del"];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)getMyCustomOrderByType:(NSInteger)type token:(NSString *)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    /*
     typedef NS_ENUM(NSInteger,CustomOrderType)
     {
     CustomOrderTypeZhuchang,
     CustomOrderTypeZhantai,
     CustomOrderTypeZhanting,
     CustomOrderTypeWutai,
     CustomOrderTypeYanyi,
     CustomOrderTypeYaoyue,
     
     CustomOrderTypeTotalCount,
     };
     */
    
    
    NSString* tail=@"";
    
    if (type==CustomOrderTypeZhuchang)
    {
        tail=@"/User/CustomOrder/home";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        tail=@"/User/CustomOrder/booth";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        tail=@"/User/CustomOrder/hall";
    }
    else if(type==CustomOrderTypeWutai)
    {
        tail=@"/User/CustomOrder/stage";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        tail=@"/User/CustomOrder/performance";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        tail=@"/User/CustomOrder/invitation";
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:tail];
    
    NSMutableDictionary* dic=[ZZHttpTool pageParamsWithPage:page size:pagesize];
    [dic setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* result=[NSMutableArray array];
        for (NSDictionary* ddd in list) {
            CustomOrderModel* ro=[[CustomOrderModel alloc]initWithDictionary:ddd];
            ro.type=type;
            [result addObject:ro];
        }
        if (success) {
            success(result);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getMyCustomOrderDetailById:(NSString *)idd type:(NSInteger)type token:(NSString *)token success:(void (^)(CustomOrderModel *))success
{
    if (token.length==0) {
        if (success) {
            success(nil);
        }
        return;
    }
    NSString* tail=@"";
    
    if (type==CustomOrderTypeZhuchang)
    {
        tail=@"/User/CustomOrder/home_detail";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        tail=@"/User/CustomOrder/booth_detail";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        tail=@"/User/CustomOrder/hall_detail";
    }
    else if(type==CustomOrderTypeWutai)
    {
        tail=@"/User/CustomOrder/stage_detail";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        tail=@"/User/CustomOrder/performance_detail";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        tail=@"/User/CustomOrder/invitation_detail";
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:tail];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self get:str params:dic usingCache:NO success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        CustomOrderModel* mo=[[CustomOrderModel alloc]initWithDictionary:data];
        mo.type=type;
        if (success) {
            success(mo);
        }
    } failure:^(NSError *err) {
        if (success) {
            success(nil);
        }
    }];
}

+(void)postMyCustomOrderCancelById:(NSString *)idd type:(NSInteger)type token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    if (token.length==0) {
        if (success) {
            success(NO,nil);
        }
        return;
    }
    NSString* tail=@"";
    
    if (type==CustomOrderTypeZhuchang)
    {
        tail=@"/User/CustomOrder/home_del";
    }
    else if(type==CustomOrderTypeZhantai)
    {
        tail=@"/User/CustomOrder/booth_del";
    }
    else if(type==CustomOrderTypeZhanting)
    {
        tail=@"/User/CustomOrder/hall_del";
    }
    else if(type==CustomOrderTypeWutai)
    {
        tail=@"/User/CustomOrder/stage_del";
    }
    else if(type==CustomOrderTypeYanyi)
    {
        tail=@"/User/CustomOrder/performance_del";
    }
    else if(type==CustomOrderTypeYaoyue)
    {
        tail=@"/User/CustomOrder/invitation_del";
    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:tail];
    
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:idd forKey:@"id"];
    [dic setValue:token forKey:@"access_token"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

+(void)postOrderStatusChangedNotificationWithOrder:(OrderTypeBaseModel *)orderModel
{
    if (orderModel) {
        NSDictionary* dictionary=[NSDictionary dictionaryWithObject:orderModel forKey:@"order"];
        [[NSNotificationCenter defaultCenter]postNotificationName:OrderTypeStatusChangedNotification object:nil userInfo:dictionary];
    }
}

@end
