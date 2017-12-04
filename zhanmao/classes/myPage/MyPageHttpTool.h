//
//  MyPageHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"

#import "AddressModel.h"
#import "UserModel.h"

@interface MyPageHttpTool : ZZHttpTool

#pragma mark address

+(void)postNewAddressEdit:(BOOL)edit param:(NSDictionary*)param success:(void(^)(BOOL result,NSString* msg,NSString* idd))success;

+(void)postDefaultAddressId:(NSString*)addid token:(NSString*)token success:(void(^)(BOOL result,NSString* msg))success;

+(void)postDeleteAddressId:(NSString*)addid token:(NSString*)token success:(void(^)(BOOL result,NSString* msg))success;

+(void)getMyAddressesToken:(NSString*)token cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

#pragma mark info

+(void)uploadAvatar:(UIImage*)avatar token:(NSString*)token success:(void(^)(NSString* imageUrl))success;

+(void)getPersonalInfoToken:(NSString*)token success:(void(^)(UserModel* user))success;

+(void)postPersonalInfo:(NSDictionary*)params success:(void(^)(BOOL result,NSString* msg))success;

+(void)getCodeWithMobile:(NSString*)mobile success:(void(^)(BOOL sent,NSString* msg))success;

+(void)loginUserWithMobile:(NSString*)mobile code:(NSString*)code success:(void(^) (NSString* token,NSString* msg))success;

@end
