//
//  RentModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/11.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentModel.h"

@implementation RentClass
@end

@implementation RentProductModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        self.rent=[[dictionary valueForKey:@"rent"]floatValue];
        self.deposit=[[dictionary valueForKey:@"deposit"]floatValue];
        self.rent_o=[[dictionary valueForKey:@"rent_o"]floatValue];
//        NSMutableArray* sem=[NSMutableArray array];
//        NSArray* semeta=[dictionary valueForKey:@"smeta"];
//        for (NSDictionary* se in semeta) {
//            NSString* url=[se valueForKey:@"url"];
//            if (url.length>0) {
//                [sem addObject:url];
//            }
//        }
//        self.smeta=sem;
    }
    return self;
}

@end

@implementation RentCartModel

@end


