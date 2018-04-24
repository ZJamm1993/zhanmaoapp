//
//  NSArray+dictionaryModel.h
//  ZhuangBeiDaQuan
//
//  Created by ZJam on 2018/2/1.
//  Copyright © 2018年 Intexh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (dictionaryModel)

+(NSMutableArray*)modelsWithDictionaries:(NSArray*)dictionaries modelCreate:(id (^)(NSInteger index, NSDictionary* dict))creater;

@end
