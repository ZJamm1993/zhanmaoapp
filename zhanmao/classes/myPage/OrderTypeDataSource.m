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

@end
