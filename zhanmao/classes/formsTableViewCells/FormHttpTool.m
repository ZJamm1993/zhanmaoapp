//
//  FormHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "FormHttpTool.h"

@implementation FormHttpTool

+(void)getCustomTableListByType:(NSInteger)type success:(void (^)(BaseFormStepsModel* ste))success failure:(void (^)(NSError *err))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Table/gettable"];
    NSDictionary* pa=[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [self get:str params:pa usingCache:NO success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSDictionary* data=[dict valueForKey:@"data"];
        
        //testing
//        if (data.count==0) {
//            NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"json.txt"];
//            NSError* err=nil;
//            NSString* json=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
//            NSData * data2 = [json dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
//            data=[result valueForKey:@"data"];
//        }
        
        BaseFormStepsModel* steps=[[BaseFormStepsModel alloc]initWithDictionary:data];
        if (success) {
            success(steps);
        }
    } failure:^(NSError *err) {
        
    }];
}

@end
