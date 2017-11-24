//
//  ExhibitionModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionModel.h"

@implementation ExhibitionModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super initWithDictionary:dictionary];
    if (self) {
        _exhibition_name=[dictionary valueForKey:@"exhibition_name"];
    }
    return self;
}

@end
