//
//  RentHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "RentModel.h"

@interface RentHttpTool : ZZHttpTool

+(void)getClasses:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getGoodListByCid:(NSString*)cid sort:(NSString*)sort page:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getGoodListSearchByKeyword:(NSString*)keyword sort:(NSString*)sort page:(NSInteger)page pageSize:(NSInteger)pagesize cached:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getGoodDetailById:(NSString*)idd cached:(BOOL)cache success:(void(^)(RentProductModel* result))success failure:(void(^)(NSError* error))failure;

+(void)addRentCarts:(NSArray*)carts success:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)getRentCartsSuccess:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)removeRentCarts:(NSArray*)carts success:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)changeRentCart:(RentCartModel*)cart;

+(void)addSearchedString:(NSString*)searchedString success:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

+(void)addSearchedStrings:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)removeSearchedStrings:(void(^)(BOOL result))success failure:(void(^)(NSError* error))failure;

@end
