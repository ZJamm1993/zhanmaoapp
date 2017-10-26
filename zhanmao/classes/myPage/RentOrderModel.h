//
//  RentOrderModel.h
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RentOrderType)
{
    RentOrderTypeAll,
    RentOrderTypeNotPaid,
    RentOrderTypeNotSigned,
    RentOrderTypeNotReturned,
    RentOrderTypeFinished,
};

@interface RentOrderModel : NSObject

@property (nonatomic,assign) RentOrderType type;
@property (nonatomic,strong) NSString* title;

+(NSString*)controllerTitleForType:(RentOrderType)type;

+(NSString*)cellTitleForType:(RentOrderType)type;

@end
