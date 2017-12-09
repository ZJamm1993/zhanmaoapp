//
//  OrderTypeBaseModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/2.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"
#import "RentModel.h"
#import "PayOrderModel.h"

/***
#warning "TYPE" is not equal to "STATUS"
 */

typedef NS_ENUM(NSInteger,RentOrderType)
{
    RentOrderTypeAll,
    RentOrderTypeNotPaid,
    RentOrderTypeNotSigned,
    RentOrderTypeNotReturned,
    RentOrderTypeFinished,
    
    RentOrderTypeTotalCount,
};

typedef NS_ENUM(NSInteger,RentOrderStatus)
{
    RentOrderStatusNotPaid,
    RentOrderStatusNotSigned,
    RentOrderStatusProcessing,
    RentOrderStatusNotReturned,
    RentOrderStatusFinished,
    RentOrderStatusDeleted,
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
//    CleanOrderTypeProceeding,
    CleanOrderTypeFinished,
};

typedef NS_ENUM(NSInteger,CustomOrderType)
{
    CustomOrderTypeZhuchang,
    CustomOrderTypeZhantai,
    CustomOrderTypeZhanting,
    CustomOrderTypeWutai,
    CustomOrderTypeYanyi,
    CustomOrderTypeYaoyue,
    
    CustomOrderTypeTotalCount,
};

/***
 
 base
 **/
@interface OrderTypeBaseModel : ZZModel

@property (nonatomic,strong) NSString* title;
@property (nonatomic,assign) NSInteger type;

+(NSString*)controllerTitleForType:(NSInteger)type;
+(NSString*)cellStateForType:(NSInteger)type;
+(NSString*)cellButtonTitleForType:(NSInteger)type;

//property from json

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* number;

@property (nonatomic,assign) NSInteger status;

@property (nonatomic,strong) NSString* amount;

@property (nonatomic,strong) NSString* pay_type;

//times
@property (nonatomic,strong) NSString* createtime;
@property (nonatomic,strong) NSString* paytime;
@property (nonatomic,strong) NSString* delivery_date;

@end

/***
 children
 **/
@interface RentOrderModel : OrderTypeBaseModel

@property (nonatomic,strong) PayOrderModel* pay;
@property (nonatomic,strong) AddressModel* address;
@property (nonatomic,strong) NSArray<RentCartModel*>* goods;

@end

@interface TransportOrderModel : OrderTypeBaseModel

@end

@interface CleanOrderModel : OrderTypeBaseModel

@end

@interface CustomOrderModel : OrderTypeBaseModel

+(NSString*)cellOrderTypeNameForType:(NSInteger)type;
+(NSString*)cellOrderIdNameForType:(NSInteger)type;
+(NSString*)cellOrderDateNameForType:(NSInteger)type;
+(NSString*)cellOrderUnitNameForType:(NSInteger)type;

@end
