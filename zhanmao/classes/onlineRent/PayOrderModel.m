//
//  PayOrderModel.m
//  zhanmao
//
//  Created by jam on 2017/12/5.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "PayOrderModel.h"

@implementation PayOrderModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _idd=[dictionary valueForKey:@"id"];
        _amount=[[dictionary valueForKey:@"amount"]doubleValue];
        _expiration=[[dictionary valueForKey:@"expiration"]doubleValue];
    }
    return self;
}

@end
