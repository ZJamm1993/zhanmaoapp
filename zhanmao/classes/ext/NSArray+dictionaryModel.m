//
//  NSArray+dictionaryModel.m
//  ZhuangBeiDaQuan
//
//  Created by ZJam on 2018/2/1.
//  Copyright © 2018年 Intexh. All rights reserved.
//

#import "NSArray+dictionaryModel.h"

@implementation NSArray (dictionaryModel)

+(NSMutableArray*)modelsWithDictionaries:(NSArray*)dictionaries modelCreate:(id (^)(NSInteger index, NSDictionary* dict))creater;
{
    NSMutableArray* results=[NSMutableArray array];
    
    if ([dictionaries isKindOfClass:[NSArray class]]) {
        NSInteger count=dictionaries.count;
        for (NSInteger i=0; i<count; i++) {
            NSDictionary* dic=[dictionaries objectAtIndex:i];
            if ([dic isKindOfClass:[NSDictionary class]]) {
                if (creater) {
                    id model=creater(i,dic);
                    [results addObject:model];
                }
            }
        }
    }
    
    return results;
}

@end
