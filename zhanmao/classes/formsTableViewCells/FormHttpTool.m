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
    BOOL test=NO;
    if (test) {
        //test
        BaseFormStepsModel* st=[self stepsFromFileName:[NSString stringWithFormat:@"%d.txt",(int)type]];
        if (success) {
            success(st);
        }
        return;
        //test
    }
    else
    {
        NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Table/gettable"];
        NSDictionary* pa=[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:type] forKey:@"type"];
        
        [self get:str params:pa usingCache:NO success:^(NSDictionary *dict) {
            NSLog(@"%@",dict);
            NSDictionary* data=[dict valueForKey:@"data"];
            
            BaseFormStepsModel* steps=[[BaseFormStepsModel alloc]initWithDictionary:data];
            if (success) {
                success(steps);
            }
        } failure:^(NSError *err) {
            
        }];
    }
}

+(BaseFormStepsModel*)stepsFromFileName:(NSString *)fileName
{
    //test
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    NSError* err=nil;
    NSString* json=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    NSData * data2 = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary* data=[result valueForKey:@"data"];
    BaseFormStepsModel* steps=[[BaseFormStepsModel alloc]initWithDictionary:data];
    return steps;
}

+(void)postCustomTableListByType:(NSInteger)type params:(NSDictionary *)params success:(void (^)(BOOL, NSString *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Table/made"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithDictionary:params];
    [dic setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        NSString* msg=[responseObject valueForKey:@"message"];
        BOOL ok=YES;//[responseObject valueForKey:@"]
        if (success) {
            success(ok,msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)getHallNames:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Hall/hall"];
    
    [self get:str params:nil usingCache:NO success:^(NSDictionary *dict) {
        NSArray* data=[dict valueForKey:@"data"];
        NSMutableArray* arr=[NSMutableArray array];
        for (NSDictionary* d in data) {
            HallModel* ha=[[HallModel alloc]initWithDictionary:d];
            [arr addObject:ha];
        }
        if (success) {
            success(arr);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

@end
