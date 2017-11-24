//
//  TravellingHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "TravellingModel.h"

@interface TravellingHttpTool : ZZHttpTool

+(void)getAdvertisementsByCid:(NSInteger)cid cache:(BOOL)cache success:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

@end
