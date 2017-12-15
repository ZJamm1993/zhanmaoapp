//
//  OrderTypeDataSource.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "OrderTypeBaseModel.h"

#define OrderTypeStatusChangedNotification @"OrderTypeStatusChangedNotification"

@interface OrderTypeDataSource : ZZHttpTool

#pragma mark rent order

+(void)getMyRentOrderByType:(NSInteger)type token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getMyRentOrderDetailById:(NSString*)idd token:(NSString*)token success:(void(^)(RentOrderModel* model))success;
+(void)postMyRentOrderCancelById:(NSString*)idd token:(NSString*)token success:(void(^)(BOOL result, NSString* msg))success;
+(void)postMyRentOrderReceiveById:(NSString *)idd token:(NSString *)token success:(void (^)(BOOL result, NSString * msg))success;

#pragma mark transport order

+(void)getMyTransportOrderByType:(NSInteger)type token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getMyTransportOrderDetailById:(NSString*)idd token:(NSString*)token success:(void(^)(TransportOrderModel* model))success;

+(void)postMyTransportOrderCancelById:(NSString*)idd token:(NSString*)token success:(void(^)(BOOL result, NSString* msg))success;

#pragma mark cleanOrder

+(void)getMyCleanOrderByType:(NSInteger)type token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getMyCleanOrderDetailById:(NSString*)idd token:(NSString*)token success:(void(^)(CleanOrderModel* model))success;
+(void)postMyCleanOrderCancelById:(NSString*)idd token:(NSString*)token success:(void(^)(BOOL result, NSString* msg))success;

#pragma mark customOrder 

//attention ! those models have no properties;

+(void)getMyCustomOrderByType:(NSInteger)type token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getMyCustomOrderDetailById:(NSString*)idd type:(NSInteger)type token:(NSString*)token success:(void(^)(CustomOrderModel* model))success;

+(void)postMyCustomOrderCancelById:(NSString*)idd type:(NSInteger)type token:(NSString*)token success:(void(^)(BOOL result, NSString* msg))success;

#pragma mark notifications

+(void)postOrderStatusChangedNotificationWithOrder:(OrderTypeBaseModel*)orderModel;

@end
