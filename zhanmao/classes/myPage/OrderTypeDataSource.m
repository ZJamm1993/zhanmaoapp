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

@end
