//
//  RentHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "RentModel.h"

@interface RentHttpTool : ZZHttpTool

+(void)getClasses:(void(^)(NSArray* result))success failure:(void(^)(NSError* error))failure;

@end
