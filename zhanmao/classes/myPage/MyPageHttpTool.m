//
//  MyPageHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageHttpTool.h"

@implementation MyPageHttpTool

+(void)postNewAddressEdit:(BOOL)edit param:(NSDictionary *)param success:(void (^)(BOOL,NSString*,NSString*))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/add"];
    if (edit) {
        str=[ZZUrlTool fullUrlWithTail:@"/User/Address/edit_post"];
    }
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=[[responseObject valueForKey:@"code"]integerValue]==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        NSString* idd=[[responseObject valueForKey:@"data"]description];
        if (success) {
            success(code,msg,idd);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"网络不通畅",@"");
        }
    }];
}

+(void)postDefaultAddressId:(NSString*)addid token:(NSString*)token success:(void(^)(BOOL result,NSString* msg))success
{
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setValue:addid forKey:@"id"];
    [param setValue:token forKey:@"access_token"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/setdefault"];
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=[[responseObject valueForKey:@"code"]integerValue]==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"网络不通畅");
        }
    }];
}

+(void)postDeleteAddressId:(NSString *)addid token:(NSString *)token success:(void (^)(BOOL, NSString *))success
{
    NSMutableDictionary* param=[NSMutableDictionary dictionary];
    [param setValue:addid forKey:@"id"];
    [param setValue:token forKey:@"access_token"];
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/del"];
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=[[responseObject valueForKey:@"code"]integerValue]==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"网络不通畅");
        }
    }];
}

+(void)getMyAddressesToken:(NSString*)token cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/index"];
    if (token.length==0) {
        return;
    }
    NSDictionary* par=[NSDictionary dictionaryWithObject:token forKey:@"access_token"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* addreDic in data) {
            AddressModel* ad=[[AddressModel alloc]initWithDictionary:addreDic];
            [arr addObject:ad];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

@end
