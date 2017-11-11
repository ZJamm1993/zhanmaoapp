//
//  RentHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentHttpTool.h"

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
        if (success) {
            success(classes);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

@end
