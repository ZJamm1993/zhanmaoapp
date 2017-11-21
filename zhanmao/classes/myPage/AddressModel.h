//
//  AddressModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/8.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZModel.h"

@interface AddressModel : ZZModel

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* addressee; //whose name?
@property (nonatomic,strong) NSString* province;
@property (nonatomic,strong) NSString* city;
@property (nonatomic,strong) NSString* district;
@property (nonatomic,strong) NSString* address;
@property (nonatomic,strong) NSString* phone;
@property (nonatomic,assign) BOOL classic;

@end
