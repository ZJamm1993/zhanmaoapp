//
//  HallModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/29.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "HallModel.h"

@implementation HallModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _hall_name=[dictionary valueForKey:@"hall_name"];
        _child=[dictionary valueForKey:@"child"];
    }
    return self;
}

@end
