//
//  ZZHttpTool.h
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZUrlTool.h"
#import "BaseModel.h"

@interface ZZHttpTool : NSObject

+(void)get:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary *dict))success failure:(void (^)(NSError *err))failure;

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(NSDictionary* responseObject))success failure:(void(^)(NSError *error))failure;

+(void)requestMethod:(NSString*)method url:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary * dict))success failure:(void (^)(NSError *err))failure;

+(NSInteger)pagesize;
+(NSMutableDictionary*)pageParams;

+(NSMutableDictionary*)pageParamsWithPage:(NSInteger)page size:(NSInteger)size;

+(NSDictionary*)dictionaryWithResponseData:(NSData*)data;

@end
