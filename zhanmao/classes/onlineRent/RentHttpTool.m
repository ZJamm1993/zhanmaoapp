//
//  RentHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentHttpTool.h"

#define RentCartsUseridKey @"i09i23rj2o3jeoi23jeo"
//#define RentCartsIdsKey @"0ire23rnt09iCari090"
#define RentCartsDaysKey @"992r3dayu8900i90901"
#define RentCartsCountKey @"09i23Cou90nt9823e2e"

#define RentSearchedStringsKey @"903ei9012e12iojwe"

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

+(void)getGoodListSearchByKeyword:(NSString *)keyword sort:(NSString *)sort page:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary* par=[self pageParamsWithPage:page size:pagesize];
    [par setValue:keyword forKey:@"keywords"];
    [par setValue:sort forKey:@"sort"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Mall/Goods/search_goods"];
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

+(void)addRentCarts:(NSArray *)carts userid:(NSString*)userid success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure
{
    NSMutableArray* ids=[NSMutableArray arrayWithArray:[self localRentCartIdsUserId:userid]];
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
        car.count=car.count+[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartCountIdKey:car userid:userid]]integerValue];
//        car.days=car.days+[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartDayIdKey:car]]integerValue];
        
        [self changeRentCart:car userid:userid];
    }
    [self saveRentCartIds:ids userid:userid];
    if(success)
    {
        success(YES);
    }
}

+(void)removeRentCarts:(NSArray *)carts userid:(NSString*)userid success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure
{
    NSMutableArray* ids=[NSMutableArray arrayWithArray:[self localRentCartIdsUserId:userid]];
    for (RentCartModel* car in carts) {
        NSString* str=car.product.idd;
        if ([ids containsObject:str]) {
            [ids removeObject:str];
        }
        car.count=0;
//        car.days=0;
        [self changeRentCart:car userid:userid];
        
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:[self mixedRentCartCountIdKey:car userid:userid]];
    }
    [self saveRentCartIds:ids userid:userid];
    if(success)
    {
        success(YES);
    }
}

+(void)getRentCartsSuccess:(void (^)(NSArray *))success userid:(NSString*)userid failure:(void (^)(NSError *))failure
{
    NSString* ids=[[self localRentCartIdsUserId:userid]componentsJoinedByString:@","];
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
            
            cart.count=[[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartCountIdKey:cart userid:userid]]integerValue];
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

+(void)getRentCartsCountSuccess:(void (^)(NSInteger))success userid:(NSString*)userid failure:(void (^)(NSError *))failure
{
    NSArray* ids=[self localRentCartIdsUserId:userid];
    NSInteger count=ids.count;
    if (count==1&&[ids.firstObject length]==0) {
        count=0;
    }
    if (success) {
        success(count);
    }
}

+(NSArray*)localRentCartIdsUserId:(NSString*)userid
{
    NSString* str=[[NSUserDefaults standardUserDefaults]valueForKey:[self mixedRentCartUseridKey:userid]];
    return [str componentsSeparatedByString:@","];
}

+(void)saveRentCartIds:(NSArray*)ids userid:(NSString*)userid
{
    NSString* str=[ids componentsJoinedByString:@","];
    [[NSUserDefaults standardUserDefaults]setValue:str forKey:[self mixedRentCartUseridKey:userid]];
}

+(void)changeRentCart:(RentCartModel*)cart userid:(NSString *)userid
{
//    NSNumber* dayNumber=[NSNumber numberWithInteger:cart.days];
    NSNumber* couNumber=[NSNumber numberWithInteger:cart.count];
    
//    [[NSUserDefaults standardUserDefaults]setValue:dayNumber forKey:[self mixedRentCartDayIdKey:cart]];
    [[NSUserDefaults standardUserDefaults]setValue:couNumber forKey:[self mixedRentCartCountIdKey:cart userid:userid]];
}

+(NSString*)mixedRentCartUseridKey:(NSString*)userid
{
    NSString* st=[NSString stringWithFormat:@"%@%@",RentCartsUseridKey,userid];
    NSLog(@"%@",st);
    return st;
}

+(NSString*)mixedRentCartCountIdKey:(RentCartModel*)cart userid:(NSString*)userid
{
    NSString* st=[NSString stringWithFormat:@"%@%@%@",cart.product.idd,RentCartsCountKey,userid];
    NSLog(@"%@",st);
    return st;
}

////////////////////////


+(NSArray*)searchedStrings
{
    NSArray* arr=[[NSUserDefaults standardUserDefaults]valueForKey:RentSearchedStringsKey];
    return arr;
}

+(void)saveSearchedStrings:(NSArray*)strs
{
    [[NSUserDefaults standardUserDefaults]setValue:strs forKey:RentSearchedStringsKey];
}

+(void)removeSearchedStrings
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:RentSearchedStringsKey];
}

+(void)addSearchedString:(NSString *)searchedString success:(void (^)(BOOL))success failure:(void (^)(NSError *))failure
{
    if (searchedString.length==0) {
        return;
    }
    NSArray* searcedArr=[self searchedStrings];
    NSMutableArray* arr=[NSMutableArray arrayWithArray:searcedArr];
    if ([arr containsObject:searchedString]) {
        [arr removeObject:searchedString];
    }
    [arr insertObject:searchedString atIndex:0];
    
    [self saveSearchedStrings:arr];
    if (success) {
        success(YES);
    }
}

+(void)getSearchedStrings:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSArray* arr=[self searchedStrings];
    if (success) {
        success(arr);
    }
}

+(void)removeSearchedStrings:(void (^)(BOOL))success failure:(void (^)(NSError *))failure
{
    [self removeSearchedStrings];
    if (success) {
        success(YES);
    }
}

+(void)getHotestSearchedStrings:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Mall/Goods/search_hot"];
    [self get:str params:nil usingCache:NO success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* jso in data) {
            NSString* post_title=[jso valueForKey:@"post_title"];
            if (post_title.length>0) {
                [res addObject:post_title];
            }
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

+(void)postRentOrderParams:(NSDictionary *)params success:(void (^)(BOOL,NSString*, PayOrderModel *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Order/add"];
    [self post:str params:params success:^(NSDictionary *responseObject) {
        BOOL result=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        NSDictionary* data=[responseObject valueForKey:@"data"];
        PayOrderModel* mo=[[PayOrderModel alloc]initWithDictionary:data];
        if (success) {
            success(result,msg,mo);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription,nil);
        }
    }];
}

+(void)getPayOrderStringWithToken:(NSString *)token orderType:(NSString*)orderType payType:(NSString *)payType orderId:(NSString *)orderId success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Pay/paypost"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"access_token"];
    [dic setValue:payType forKey:@"pid"];
    [dic setValue:orderId forKey:@"oid"];
    [dic setValue:orderType forKey:@"type"];
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
