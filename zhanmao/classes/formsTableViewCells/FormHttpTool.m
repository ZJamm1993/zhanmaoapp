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
    
//    BOOL test=NO;
//    if (test) {
//        //test
//        BaseFormStepsModel* st=[self stepsFromFileName:[NSString stringWithFormat:@"%ld.txt",(long)type]];
//        if (success) {
//            success(st);
//        }
//        return;
//        //test
//    }
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Table/gettable"];
    NSMutableDictionary* pa=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:type] forKey:@"type"];
    [pa setValue:[UserModel token] forKey:@"access_token"];
    [self get:str params:pa usingCache:NO success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        NSDictionary* data=[dict valueForKey:@"data"];
        
        BaseFormStepsModel* steps=[[BaseFormStepsModel alloc]initWithDictionary:data];
        if (success) {
            success(steps);
        }
        
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

//+(BaseFormStepsModel*)stepsFromFileName:(NSString *)fileName
//{
//    //test
//    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
//    NSError* err=nil;
//    NSString* json=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
//    NSData * data2 = [json dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
//    NSDictionary* data=[result valueForKey:@"data"];
//    BaseFormStepsModel* steps=[[BaseFormStepsModel alloc]initWithDictionary:data];
//    return steps;
//}

+(void)postCustomTableListByType:(NSInteger)type params:(NSDictionary *)params success:(void (^)(BOOL, NSString *,PayOrderModel*))success failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Custom/Table/made"];
    NSMutableDictionary* dic=[NSMutableDictionary dictionaryWithDictionary:params];
    [dic setValue:[NSNumber numberWithInteger:type] forKey:@"type"];
    
    [self post:str params:dic success:^(NSDictionary *responseObject) {
        NSString* msg=[responseObject valueForKey:@"message"];
        BOOL ok=responseObject.code==0;
        PayOrderModel* mo=[[PayOrderModel alloc]initWithDictionary:[responseObject valueForKey:@"data"]];
        if (success) {
            success(ok,msg,mo);
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
