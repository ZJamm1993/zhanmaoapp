//
//  RentHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "RentModel.h"
#import "PayOrderModel.h"

//#define RentCartCountDidChangedNotification @"RentCartCountDidChangedNotification"

@interface RentHttpTool : ZZHttpTool

#pragma mark products

+(void)getClasses:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getGoodListByCid:(NSString*)cid sort:(NSString*)sort page:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getGoodListSearchByKeyword:(NSString*)keyword sort:(NSString*)sort page:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getGoodDetailById:(NSString*)idd cached:(BOOL)cache success:(void(^)(RentProductModel* result))success failure:(void(^)(NSError* error))failure;

#pragma mark carts

+(void)addRentCarts:(NSArray*)carts userid:(NSString*)userid success:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)getRentCartsSuccess:(void(^)(NSArray* result))success userid:(NSString*)userid failure:(void(^)(NSError* error))failure;

+(void)getRentCartsCountSuccess:(void(^)(NSInteger count))success userid:(NSString*)userid failure:(void(^)(NSError* error))failure;

+(void)removeRentCarts:(NSArray*)carts userid:(NSString*)userid success:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)changeRentCart:(RentCartModel*)cart userid:(NSString*)userid;

#pragma mark search

+(void)addSearchedString:(NSString*)searchedString success:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)getSearchedStrings:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)removeSearchedStrings:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)getHotestSearchedStrings:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

#pragma mark orders

+(void)postRentOrderParams:(NSDictionary*)params success:(void(^)(BOOL result, NSString* msg, PayOrderModel* order))success;
+(void)getPayOrderStringWithToken:(NSString*)token orderType:(NSString*)orderType payType:(NSString*)payType orderId:(NSString*)orderId success:(void(^)(NSDictionary* dictionary))success failure:(void(^)(NSError* error))failure;

@end
