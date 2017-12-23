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
        self.goods_id=[dictionary valueForKey:@"goods_id"];
        self.rent=[[dictionary valueForKey:@"rent"]doubleValue];
        self.deposit=[[dictionary valueForKey:@"deposit"]doubleValue];
        self.rent_o=[[dictionary valueForKey:@"rent_o"]doubleValue];
    }
    return self;
}

@end

@implementation RentCartModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        //attention!!! the "product" uses the same dictionary;
        _product=[[RentProductModel alloc]initWithDictionary:dictionary];
        _days=[[dictionary valueForKey:@"goods_days"]integerValue];
        _count=[[dictionary valueForKey:@"sale_num"]integerValue];
    }
    return self;
}

@end




