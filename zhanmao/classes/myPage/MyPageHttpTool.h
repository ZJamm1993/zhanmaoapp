//
//  MyPageHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"

#import "AddressModel.h"

@interface MyPageHttpTool : ZZHttpTool

+(void)postNewAddressEdit:(BOOL)edit param:(NSDictionary*)param success:(void(^)(BOOL result,NSString* msg,NSString* idd))success;

+(void)postDefaultAddressId:(NSString*)addid token:(NSString*)token success:(void(^)(BOOL result,NSString* msg))success;

+(void)postDeleteAddressId:(NSString*)addid token:(NSString*)token success:(void(^)(BOOL result,NSString* msg))success;

+(void)getMyAddressesToken:(NSString*)token cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

@end
