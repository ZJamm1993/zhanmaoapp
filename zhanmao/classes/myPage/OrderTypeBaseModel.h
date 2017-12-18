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
    RentOrderStatusUnknown=-1,
    RentOrderStatusNotSent=0,
    RentOrderStatusNotReceived=1,
    RentOrderStatusNotReturn=3,
    RentOrderStatusReturning=4,
    RentOrderStatusCanceled=5,
    RentOrderStatusFinishing=6,
    RentOrderStatusFinished=7,
};

typedef NS_ENUM(NSInteger,TransportOrderType)
{
    TransportOrderTypeNow=1,
    TransportOrderTypeHistory=2,
};

typedef NS_ENUM(NSInteger,TransportOrderStatus)
{
    TransportOrderStatusCancel=0,
    TransportOrderStatusCompleted=1,
    TransportOrderStatusSubmited=2,
};

typedef NS_ENUM(NSInteger,CleanOrderType)
{
    CleanOrderTypeAll,
    CleanOrderTypeNotPaid,
    CleanOrderTypeProceeding,
    CleanOrderTypeFinished,
    
    CleanOrderTypeTotalCount,
};

typedef NS_ENUM(NSInteger,CleanOrderStatus)
{
    CleanOrderStatusNotClean=0,
    CleanOrderStatusCleaned=1,
    CleanOrderStatusCanceled=5,
    CleanOrderStatusFinished=6,
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

typedef NS_ENUM(NSInteger,CustomOrderStatus)
{
    CustomOrderStatusCanceled=0,
    CustomOrderStatusCompleted=1,
    CustomOrderStatusSubmited=2,
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
+(NSString*)detailHeaderTitleForType:(NSInteger)type;
+(NSString*)detailHeaderDescritionForType:(NSInteger)type;

//property from json

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* number;
@property (nonatomic,strong) NSString* order_num;

//@property (nonatomic,assign) NSInteger status;

@property (nonatomic,assign) NSInteger pay_status;
@property (nonatomic,assign) NSInteger order_status; //some key is "status"

@property (nonatomic,assign) CGFloat amount;
@property (nonatomic,assign) CGFloat expiration;

@property (nonatomic,strong) NSString* pay_type;

//times
@property (nonatomic,strong) NSString* createtime;
@property (nonatomic,strong) NSString* paytime;

@property (nonatomic,strong) NSString* post_modified;

@end

/***
 children
 **/
@interface RentOrderModel : OrderTypeBaseModel

@property (nonatomic,assign) NSInteger leaseperiod;

@property (nonatomic,strong) NSString* delivery_date;
@property (nonatomic,strong) NSString* return_date;
@property (nonatomic,strong) NSString* recover_date;

@property (nonatomic,strong) NSString* emergency_phone;

@property (nonatomic,strong) PayOrderModel* pay;
@property (nonatomic,strong) AddressModel* address;
@property (nonatomic,strong) NSArray<RentCartModel*>* goods;

@end

@interface TransportOrderModel : OrderTypeBaseModel

@property (nonatomic,strong) NSString* logistics_type;

@property (nonatomic,strong) NSString* sender;
@property (nonatomic,strong) NSString* collect;

@property (nonatomic,strong) NSString* send_date;
@property (nonatomic,strong) NSString* item_type;
@property (nonatomic,strong) NSString* volume;
@property (nonatomic,strong) NSString* professor;
@property (nonatomic,strong) NSString* evaluate;
@property (nonatomic,strong) NSString* sender_addr;
@property (nonatomic,strong) NSString* collect_addr;

@end

@interface CleanOrderModel : OrderTypeBaseModel

@property (nonatomic,assign) CGFloat cost;
@property (nonatomic,assign) CGFloat other_cost;

@property (nonatomic,assign) CGFloat professor;
@property (nonatomic,assign) CGFloat other;

@property (nonatomic,strong) NSString* addressee;
@property (nonatomic,strong) NSString* m_phone;
@property (nonatomic,strong) NSString* date;
@property (nonatomic,strong) NSString* addr;

@property (nonatomic,strong) PayOrderModel* pay;


@end

@interface CustomOrderModel : OrderTypeBaseModel

+(NSString*)cellOrderTypeNameForType:(NSInteger)type;
+(NSString*)cellOrderIdNameForType:(NSInteger)type;
+(NSString*)cellOrderDateNameForType:(NSInteger)type;
+(NSString*)cellOrderUnitNameForType:(NSInteger)type;

//no property here, use "value for key:" :-(

@end
