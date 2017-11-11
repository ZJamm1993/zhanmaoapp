//
//  RentModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentModel.h"

@implementation RentClass

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    self.name=[dictionary valueForKey:@"name"];
    self.cid=[dictionary valueForKey:@"cid"];
    return self;
}

@end

@implementation RentModel

@end
