//
//  MainPageHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/15.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MainPageHttpTool.h"

@implementation MainPageHttpTool

+(void)getCustomShowingListByType:(NSString*)type cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Show/classification"];
    NSDictionary* par=[NSDictionary dictionaryWithObject:type forKey:@"type"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* di in data) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:di];
            [res addObject:m];
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

+(void)getCustomShowingCaseListByCid:(NSString*)cid cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Show/caselist"];
    NSDictionary* par=[NSDictionary dictionaryWithObject:cid forKey:@"cid"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* di in data) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:di];
            [res addObject:m];
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

+(void)getNewExhibitions:(void (^)(NSArray *))success cache:(BOOL)cache failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Exhibition/new_exhibition"];
    [self get:str params:nil usingCache:cache success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* di in data) {
            ExhibitionModel* exh=[[ExhibitionModel alloc]initWithDictionary:di];
            [res addObject:exh];
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

+(void)getExhibitionDetailById:(NSString *)idd success:(void (^)(ExhibitionModel *))success cache:(BOOL)cache failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Exhibition/detail"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    if (idd.length==0) {
        if (failure) {
            failure(nil);
        }
    }
    [dic setValue:idd forKey:@"id"];
    [self get:str params:dic usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        ExhibitionModel* exh=[[ExhibitionModel alloc]initWithDictionary:data];
        if(success)
        {
            success(exh);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(void)getNewMessagesPage:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary* par=[self pageParamsWithPage:page size:pagesize];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/News/news_all"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            MainMsgModel* msg=[[MainMsgModel alloc]initWithDictionary:dic];
            [res addObject:msg];
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
