//
//  OrderTypeBaseModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
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

typedef NS_ENUM(NSInteger,TransportOrderType)
{
    TransportOrderTypeNow,
    TransportOrderTypeHistory,
};

typedef NS_ENUM(NSInteger,CleanOrderType)
{
    CleanOrderTypeAll,
    CleanOrderTypeNotPaid,
    CleanOrderTypeProceeding,
    CleanOrderTypeFinished,
};

typedef NS_ENUM(NSInteger,CustomOrderType)
{
    CustomOrderTypeNow,
    CustomOrderTypeHistory,
};

/***
 
 base
 **/
@interface OrderTypeBaseModel : NSObject

@property (nonatomic,strong) NSString* title;
@property (nonatomic,assign) NSInteger type;

+(NSString*)controllerTitleForType:(NSInteger)type;
+(NSString*)cellStateForType:(NSInteger)type;
+(NSString*)cellButtonTitleForType:(NSInteger)type;

@end

/***
 children
 **/
@interface RentOrderModel : OrderTypeBaseModel


@end

@interface TransportOrderModel : OrderTypeBaseModel

@end

@interface CleanOrderModel : OrderTypeBaseModel

@end

@interface CustomOrderModel : OrderTypeBaseModel

@end
