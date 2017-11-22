//
//  RentHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentHttpTool.h"

#define RentCartsIdsKey @"0ire23rnt09iCari090"
#define RentCartsDaysKey @"992r3dayu8900i90901"
#define RentCartsCountKey @"09i23Cou90nt9823e2e"

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

+(void)getGoodDetailById:(NSString *)idd cached:(BOOL)cache success:(void (^)(RentProductModel *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Mall/Goods/show"];
    NSDictionary* par=[NSDictionary dictionaryWithObject:idd forKey:@"id"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        RentProductModel* re=[[RentProductModel alloc]initWithDictionary:data];
        if (success) {
            success(re);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

#pragma mark rent carts operation

+(void)addRentCarts:(NSArray *)carts success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure
{
    NSMutableArray* ids=[NSMutableArray arrayWithArray:[self localRentCartIds]];
    for (RentCartModel* car in carts) {
        NSString* str=car.product.idd;
        if ([ids containsObject:str]) {
            [ids removeObject:str];
            [ids insertObject:str atIndex:0];
        }
        else
        {
            [ids insertObject:str atIndex:0];
        }
        car.count=car.count+[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartCountIdKey:car]]integerValue];
//        car.days=car.days+[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartDayIdKey:car]]integerValue];
        [self changeRentCart:car];
    }
    [self saveRentCartIds:ids];
    if(success)
    {
        success(YES);
    }
}

+(void)removeRentCarts:(NSArray *)carts success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure
{
    NSMutableArray* ids=[NSMutableArray arrayWithArray:[self localRentCartIds]];
    for (RentCartModel* car in carts) {
        NSString* str=car.product.idd;
        if ([ids containsObject:str]) {
            [ids removeObject:str];
        }
        car.count=0;
//        car.days=0;
        [self changeRentCart:car];
    }
    [self saveRentCartIds:ids];
    if(success)
    {
        success(YES);
    }
}

+(void)getRentCartsSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* ids=[[self localRentCartIds]componentsJoinedByString:@","];
    if (ids.length==0) {
        return;
    }
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Mall/Goods/getList_ids"];
    NSDictionary* par=[NSDictionary dictionaryWithObject:ids forKey:@"ids"];
    [self get:str params:par usingCache:NO success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* resu=[NSMutableArray array];
        for (NSDictionary* pr in list) {
            RentProductModel* pro=[[RentProductModel alloc]initWithDictionary:pr];
            RentCartModel* cart=[[RentCartModel alloc]init];
            cart.product=pro;
//            cart.days=[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartDayIdKey:cart]]integerValue];
            cart.count=[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartCountIdKey:cart]]integerValue];
            [resu addObject:cart];
        }
        if (success) {
            success(resu);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

+(NSArray*)localRentCartIds
{
    NSString* str=[[NSUserDefaults standardUserDefaults]valueForKey:RentCartsIdsKey];
    return [str componentsSeparatedByString:@","];
}

+(void)saveRentCartIds:(NSArray*)ids
{
    NSString* str=[ids componentsJoinedByString:@","];
    [[NSUserDefaults standardUserDefaults]setValue:str forKey:RentCartsIdsKey];
}

+(void)changeRentCart:(RentCartModel*)cart
{
//    NSNumber* dayNumber=[NSNumber numberWithInteger:cart.days];
    NSNumber* couNumber=[NSNumber numberWithInteger:cart.count];
    
//    [[NSUserDefaults standardUserDefaults]setValue:dayNumber forKey:[self mixedRentCartDayIdKey:cart]];
    [[NSUserDefaults standardUserDefaults]setValue:couNumber forKey:[self mixedRentCartCountIdKey:cart]];
}

//+(NSString*)mixedRentCartDayIdKey:(RentCartModel*)cart
//{
//    return [NSString stringWithFormat:@"%@%@",RentCartsDaysKey,cart.product.idd];
//}

+(NSString*)mixedRentCartCountIdKey:(RentCartModel*)cart
{
    return [NSString stringWithFormat:@"%@%@",RentCartsCountKey,cart.product.idd];
}

@end
