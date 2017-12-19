//
//  TravellingHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TravellingHttpTool.h"
#import "FormHttpTool.h"

@implementation TravellingHttpTool

+(void)getAdvertisementsByCid:(NSString*)cid cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSDictionary* par=[NSDictionary dictionaryWithObject:cid forKey:@"cid"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Slide/index"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            TravellingModel* tra=[[TravellingModel alloc]initWithDictionary:dic];
            [res addObject:tra];
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

+(void)getServiceProviderType:(NSString*)type page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    
    NSMutableDictionary* par=[self pageParamsWithPage:page size:pagesize];
    [par setValue:type forKey:@"type"];
    
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Travel/travel_service"];
    [self get:str params:par usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSArray* list=[data valueForKey:@"list"];
        NSMutableArray* res=[NSMutableArray array];
        for (NSDictionary* dic in list) {
            TravellingModel* tra=[[TravellingModel alloc]initWithDictionary:dic];
            [res addObject:tra];
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

+(void)getTravelQuestionnaire:(void (^)(BaseFormStepsModel *))success cache:(BOOL)cache failure:(void (^)(NSError *))failure
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Travel/gettable"];
    [self get:str params:nil usingCache:cache success:^(NSDictionary *dict) {
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
    
//    [FormHttpTool getCustomTableListByType:9 success:^(BaseFormStepsModel *step) {
//        if (success) {
//            success(step);
//        }
//    } failure:^(NSError *err) {
//        if (failure) {
//            failure(err);
//        }
//    }];
}

+(void)postTravelQuestionnaireParams:(NSDictionary *)parms success:(void (^)(BOOL, NSString *))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/Content/Travel/made"];
    [self post:str params:parms success:^(NSDictionary *responseObject) {
        BOOL code=responseObject.code==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,BadNetworkDescription);
        }
    }];
}

@end
