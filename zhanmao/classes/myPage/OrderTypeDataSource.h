//
//  OrderTypeDataSource.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "OrderTypeBaseModel.h"

@interface OrderTypeDataSource : ZZHttpTool

+(void)getMyRentOrderByType:(NSInteger)type token:(NSString*)token page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

@end
