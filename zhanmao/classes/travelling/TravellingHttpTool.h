//
//  TravellingHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "TravellingModel.h"
#import "BaseFormStepsModel.h"

@interface TravellingHttpTool : ZZHttpTool

+(void)getAdvertisementsByCid:(NSString*)cid cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getServiceProviderType:(NSString*)type page:(NSInteger)page pagesize:(NSInteger)pagesize cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

+(void)getTravelQuestionnaire:(void(^)(BaseFormStepsModel* steps))success cache:(BOOL)cache failure:(void(^)(NSError* error))failure;

+(void)postTravelQuestionnaireParams:(NSDictionary*)parms success:(void(^)(BOOL result,NSString* msg))success;

@end
