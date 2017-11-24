//
//  TravellingModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TravellingModel.h"

@implementation TravellingModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _service_id=[dictionary valueForKey:@"service_id"];
        _provider=[dictionary valueForKey:@"provider"];
        _url=[dictionary valueForKey:@"url"];
    }
    return self;
}

@end
