//
//  MyPageHttpTool.m
//  zhanmao
//
//  Created by bangju on 2017/11/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MyPageHttpTool.h"

@implementation MyPageHttpTool

+(void)postNewAddressParam:(NSDictionary *)param success:(void (^)(BOOL,NSString*))success
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/User/Address/add"];
    [self post:str params:param success:^(NSDictionary *responseObject) {
        BOOL code=[[responseObject valueForKey:@"code"]integerValue]==0;
        NSString* msg=[responseObject valueForKey:@"message"];
        if (success) {
            success(code,msg);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(NO,@"网络不通畅");
        }
    }];
}

@end
