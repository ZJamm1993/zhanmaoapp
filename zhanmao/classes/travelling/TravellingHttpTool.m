//
//  TravellingHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TravellingHttpTool.h"

@implementation TravellingHttpTool

+(void)getAdvertisementsByCid:(NSInteger)cid cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSDictionary* par=[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:cid] forKey:@"cid"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Travel/advs"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            TravellingModel* tra=[[TravellingModel alloc]initWithDictionary:dic];
            [res addObject:tra];
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

+(void)getServiceProviderPage:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSDictionary* par=[self pageParamsWithPage:page size:pagesize];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Travel/service"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            TravellingModel* tra=[[TravellingModel alloc]initWithDictionary:dic];
            [res addObject:tra];
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
