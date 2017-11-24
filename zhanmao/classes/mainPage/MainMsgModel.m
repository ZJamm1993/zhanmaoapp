//
//  MainMsgModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MainMsgModel.h"

@implementation MainMsgModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _type=[[dictionary valueForKey:@"type"]integerValue];
    }
    return self;
}

@end
