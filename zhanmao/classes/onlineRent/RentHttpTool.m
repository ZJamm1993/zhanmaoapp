//
//  RentHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentHttpTool.h"

@implementation RentHttpTool

+(void)getClasses:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Mall/Goods/classification"];
    [self get:str params:nil usingCache:NO success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* classes=[NSMutableArray array];
        for (NSDictionary* cld in data) {
            RentClass* class=[[RentClass alloc]initWithDictionary:cld];
            [classes addObject:class];
        }
        RentClass* allClass=[[RentClass alloc]init];
        allClass.cid=@"0";
        allClass.name=@"全部";
        [classes insertObject:allClass atIndex:0];
        if (success) {
            success(classes);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getGoodListByCid:(NSString *)cid sort:(NSString *)sort page:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary* par=[self pageParamsWithPage:page size:pagesize];
    [par setValue:cid forKey:@"cid"];
    [par setValue:sort forKey:@"sort"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Mall/Goods/getList"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            RentProductModel* pro=[[RentProductModel alloc]initWithDictionary:dic];
            [res addObject:pro];
        }
        if (success) {
            success(res);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

@end
