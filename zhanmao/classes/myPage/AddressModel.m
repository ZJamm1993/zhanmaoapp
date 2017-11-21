//
//  AddressModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/8.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.idd=[dictionary valueForKey:@"id"];
        self.addressee=[dictionary valueForKey:@"addressee"];
        self.phone=[dictionary valueForKey:@"phone"];
        self.province=[dictionary valueForKey:@"province"];
        self.city=[dictionary valueForKey:@"city"];
        self.district=[dictionary valueForKey:@"district"];
        self.address=[dictionary valueForKey:@"address"];
        self.classic=[[dictionary valueForKey:@"classic"]boolValue];
    }
    return self;
}

@end
