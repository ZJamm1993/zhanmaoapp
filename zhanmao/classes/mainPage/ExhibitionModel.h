//
//  ExhibitionModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseModel.h"

@interface ExhibitionModel : BaseModel

@property (nonatomic,strong) NSString* exhibition_name;
@property (nonatomic,strong) NSString* start_date;
@property (nonatomic,strong) NSString* end_date;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* address;
@property (nonatomic,strong) NSString* hall_name;
@property (nonatomic,strong) NSString* sponsor;
@property (nonatomic,strong) NSString* organizer;
@property (nonatomic,strong) NSString* exhibition_description;
@property (nonatomic,strong) NSArray<NSNumber*>* types;
@property (nonatomic,strong) NSDictionary* prefixDictionary; //use for form

@end
