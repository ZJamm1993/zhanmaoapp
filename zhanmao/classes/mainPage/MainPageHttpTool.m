//
//  MainPageHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/15.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MainPageHttpTool.h"

@implementation MainPageHttpTool

+(void)getCustomShowingListByType:(NSInteger)type cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Show/classification"];
    NSDictionary* par=[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* di in data) {
            BaseModel* m=[[BaseModel alloc]initWithDictionary:di];
            [res addObject:m];
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

@end
