//
//  MyPageHttpTool.h
//  zhanmao
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"

@interface MyPageHttpTool : ZZHttpTool

+(void)postNewAddressParam:(NSDictionary*)param success:(void(^)(BOOL result,NSString* msg))success;

@end
