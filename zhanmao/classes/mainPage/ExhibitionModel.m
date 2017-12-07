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
        
        _start_date=[dictionary valueForKey:@"start_date"];
        _end_date=[dictionary valueForKey:@"end_date"];
        _city=[dictionary valueForKey:@"city"];
        _address=[dictionary valueForKey:@"address"];
        _hall_name=[dictionary valueForKey:@"hall_name"];
        _sponsor=[dictionary valueForKey:@"sponsor"];
        _organizer=[dictionary valueForKey:@"organizer"];
        _exhibition_description=[dictionary valueForKey:@"exhibition_description"];
        
        NSDictionary* custom=[dictionary valueForKey:@"custom"];
        NSArray* tya=[custom valueForKey:@"type"];
        NSMutableArray* my_Types=[NSMutableArray array];
        for (NSString* str in tya) {
            NSNumber* num=[NSNumber numberWithInteger:str.integerValue-1];
            [my_Types addObject:num];
        }
        _types=my_Types;
        
        _prefixDictionary=[custom valueForKey:@"yutian"];
    }
    return self;
}

@end
